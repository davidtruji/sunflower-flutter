import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sunflower_flutter/data/datasource/local/garden_planting_dao.dart';
import 'package:sunflower_flutter/data/datasource/local/local.dart';
import 'package:sunflower_flutter/data/datasource/local/plant_dao.dart';
import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';
import 'package:sunflower_flutter/domain/model/plant_garden_planting.dart';

class SqliteLocal extends Local {
  final Database database;
  late PlantDao plantDao;
  late GardenPlantingDao gardenPlantingDao;

  SqliteLocal(this.database) {
    plantDao = PlantDao(database);
    gardenPlantingDao = GardenPlantingDao(database);
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

  @override
  Future<List<Plant>> getAllPlants() async {
    List<Plant> plants = await plantDao.getAllPlants();

    if (plants.isEmpty) {
      await populateDataBase(); // Initializes DB on first time execution
    }

    return plantDao.getAllPlants();
  }

  @override
  Future<List<GardenPlanting>> getGardenPlantings() async {
    return gardenPlantingDao.getGardenPlantings();
  }

  @override
  Future<List<PlantGardenPlanting>> getPlantGardenPlanting() async {
    List<GardenPlanting> gardenPlantings = await getGardenPlantings();
    List<PlantGardenPlanting> plantGardenPlantings = [];

    for (GardenPlanting g in gardenPlantings) {
      Plant p = await plantDao.getPlantById(g.plantId);
      plantGardenPlantings
          .add(PlantGardenPlanting(plant: p, gardenPlanting: g));
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

  Future<void> populateDataBase() async {
    debugPrint("Populate database");
    List<Plant> plants = await readPlantsFromJSON();
    await batchPlantInsert(plants);
  }

  @override
  Future<Plant> getPlantById(String plantId) {
    return plantDao.getPlantById(plantId);
  }
}
