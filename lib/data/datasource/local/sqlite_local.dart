import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sunflower_flutter/data/datasource/local/garden_planting_dao.dart';
import 'package:sunflower_flutter/data/datasource/local/local.dart';
import 'package:sunflower_flutter/data/datasource/local/plant_dao.dart';
import 'package:sunflower_flutter/data/model/garden_planting_data.dart';
import 'package:sunflower_flutter/data/model/plant_data.dart';
import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';

class SqliteLocal extends Local {
  final Database database;
  late PlantDao plantDao;
  late GardenPlantingDao gardenPlantingDao;

  SqliteLocal(this.database) {
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
