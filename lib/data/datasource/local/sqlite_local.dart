import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sunflower_flutter/data/datasource/local/garden_planting_dao.dart';
import 'package:sunflower_flutter/data/datasource/local/local.dart';
import 'package:sunflower_flutter/data/datasource/local/plant_dao.dart';
import 'package:sunflower_flutter/data/model/garden_planting_data.dart';
import 'package:sunflower_flutter/data/model/plant_data.dart';
import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';

class SqliteLocal extends Local {
  late final Database database;
  late PlantDao plantDao;
  late GardenPlantingDao gardenPlantingDao;

  Future<Database> _getDataBase() async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      final databaseFactory = databaseFactoryFfi;
      final appDocumentsDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentsDir.path, "Sunflower", "data.db");
      final winLinuxDB = await databaseFactory.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: _onCreateDataBase,
        ),
      );
      return winLinuxDB;
    } else if (Platform.isAndroid || Platform.isIOS) {
      final path = join(await getDatabasesPath(), "data.db");
      final iOSAndroidDB = await openDatabase(
        path,
        version: 1,
        onCreate: _onCreateDataBase,
      );

      return iOSAndroidDB;
    }
    throw Exception("Unsupported platform");
  }

  Future<void> _onCreateDataBase(Database database, int version) async {
    debugPrint("Creating database");
    final db = database;

    // Create plants table
    await db.execute(""" CREATE TABLE IF NOT EXISTS plants(
            plantId TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            growZoneNumber INTEGER,
            wateringInterval INTEGER,
            imageUrl TEXT
          )
 """);

    // Create garden table
    await db.execute(""" CREATE TABLE IF NOT EXISTS garden_plantings(
            gardenPlantingId TEXT PRIMARY KEY,
            plantId TEXT,
            plantDate TEXT,
            lastWateringDate TEXT
          )
 """);
  }

  Future<void> initializeBD() async {
    database = await _getDataBase();
    plantDao = PlantDao(database);
    gardenPlantingDao = GardenPlantingDao(database);
  }

  Future<List<PlantData>> _readPlantsFromJSON() async {
    try {
      final String response = await rootBundle.loadString('assets/plants.json');
      final parsed =
          (jsonDecode(response) as List).cast<Map<String, dynamic>>();
      return parsed.map<PlantData>((json) => PlantData.fromJson(json)).toList();
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }

  @override
  Future<List<Plant>> getAllPlants() async {
    List<Plant> plants = await plantDao.getAllPlants();

    if (plants.isEmpty) {
      await _populateDataBase(); // Initializes DB on first time execution
    }

    return plantDao.getAllPlants();
  }

  Future<List<GardenPlantingData>> _getGardenPlantings() async {
    return gardenPlantingDao.getGardenPlantings();
  }

  @override
  Future<List<GardenPlanting>> getGardenPlantings() async {
    List<GardenPlantingData> gardenPlantings = await _getGardenPlantings();
    List<GardenPlanting> plantGardenPlantings = [];

    for (GardenPlantingData g in gardenPlantings) {
      Plant p = await plantDao.getPlantById(g.plantId);
      plantGardenPlantings.add(GardenPlanting(
          gardenPlantingId: p.plantId,
          plantId: p.plantId,
          name: p.name,
          wateringInterval: p.wateringInterval,
          imageUrl: p.imageUrl,
          plantDate: g.plantDate,
          lastWateringDate: g.lastWateringDate));
    }

    return plantGardenPlantings;
  }

  @override
  Future<void> insertGardenPlanting(GardenPlanting gardenPlanting) async {
    await gardenPlantingDao.insertGardenPlanting(gardenPlanting);
  }

  @override
  Future<void> batchPlantInsert(List<Plant> plantList) async {
    await plantDao.batchInsert(plantList);
  }

  Future<void> _populateDataBase() async {
    debugPrint("Populate database");
    List<PlantData> jsonFilePlants = await _readPlantsFromJSON();

    List<Plant> plants = List.generate(jsonFilePlants.length, (index) {
      return jsonFilePlants[index].toPlant();
    });

    await batchPlantInsert(plants);
  }

  @override
  Future<Plant> getPlantById(String plantId) {
    return plantDao.getPlantById(plantId);
  }

  @override
  Future<bool> isAddedToGarden(String plantId) {
    return gardenPlantingDao.isAddedToGarden(plantId);
  }
}
