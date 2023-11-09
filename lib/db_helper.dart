import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:sunflower_flutter/garden_planting.dart';
import 'package:sunflower_flutter/plant.dart';
import 'package:sunflower_flutter/plant_garden_planting.dart';

class DBHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      final databaseFactory = databaseFactoryFfi;
      final appDocumentsDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentsDir.path, "databases", "data.db");
      final winLinuxDB = await databaseFactory.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(
          version: 2,
          onCreate: _onCreate,
        ),
      );
      return winLinuxDB;
    } else if (Platform.isAndroid || Platform.isIOS) {
      final path = join(await getDatabasesPath(), "data.db");
      final iOSAndroidDB = await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );

      return iOSAndroidDB;
    }
    throw Exception("Unsupported platform");
  }

  Future<void> _onCreate(Database database, int version) async {
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
            gardenPlantingId INTEGER PRIMARY KEY,
            plantId TEXT,
            plantDate TEXT,
            lastWateringDate TEXT
          )
 """);

    // Only executes the first time
    populateDataBase();
  }

  Future<List<Plant>> readPlantsFromJSON() async {
    try {
      final String response = await rootBundle.loadString('assets/plants.json');
      final parsed =
          (jsonDecode(response) as List).cast<Map<String, dynamic>>();
      return parsed.map<Plant>((json) => Plant.fromJson(json)).toList();
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }

  Future<List<Plant>> getAllPlants() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('plants');

    return List.generate(maps.length, (index) {
      return Plant(
        plantId: maps[index]['plantId'],
        name: maps[index]['name'],
        description: maps[index]['description'],
        growZoneNumber: maps[index]['growZoneNumber'],
        wateringInterval: maps[index]['wateringInterval'],
        imageUrl: maps[index]['imageUrl'],
      );
    });
  }

  Future<List<GardenPlanting>> getGardenPlantings() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('garden_plantings');

    return List.generate(maps.length, (index) {
      return GardenPlanting(
        gardenPlantingId: maps[index]['gardenPlantingId'],
        plantId: maps[index]['plantId'],
        plantDate: maps[index]['plantDate'],
        lastWateringDate: maps[index]['lastWateringDate'],
      );
    });
  }

  Future<List<PlantGardenPlanting>> getPlantGardenPlanting() async {
    List<GardenPlanting> gardenPlantings = await getGardenPlantings();
    List<PlantGardenPlanting> plantGardenPlantings = [];

    for (GardenPlanting g in gardenPlantings) {
      Plant p = await getPlantById(g.plantId);
      plantGardenPlantings
          .add(PlantGardenPlanting(plant: p, gardenPlanting: g));
    }

    return plantGardenPlantings;
  }

  void insertPlant(Plant plant) async {
    final db = await database;
    db.insert(
      "plants",
      plant.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  void insertGardenPlanting(GardenPlanting gardenPlanting) async {
    final db = await database;
    db.insert(
      "garden_plantings",
      gardenPlanting.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  void batchInsert(List<Plant> plantList) async {
    final db = await database;
    final batch = db.batch();

    for (final Plant plant in plantList) {
      batch.insert(
        'plants',
        plant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    await batch.commit();
  }

  void populateDataBase() async {
    debugPrint("Populate database");
    readPlantsFromJSON().then((plants) => batchInsert(plants));
  }

  Future<Plant> getPlantById(String plantId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'plants',
      where: 'plantId = ?',
      whereArgs: [plantId],
    );

    return Plant(
      plantId: maps[0]['plantId'],
      name: maps[0]['name'],
      description: maps[0]['description'],
      growZoneNumber: maps[0]['growZoneNumber'],
      wateringInterval: maps[0]['wateringInterval'],
      imageUrl: maps[0]['imageUrl'],
    );
  }

/*
  Future<void> deleteAllUsers() async {
    final db = await database;
    final Batch batch = db.batch();

    batch.delete('users');

    await batch.commit();
  }


   */
}
