import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sunflower_flutter/data/model/plant_data.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';

class PlantDao {
  final Database database;

  PlantDao(this.database);

  Future<List<Plant>> getAllPlants() async {
    final db = database;
    final List<Map<String, dynamic>> maps = await db.query('plants');

    return List.generate(maps.length, (index) {
      return PlantData(
        plantId: maps[index]['plantId'],
        name: maps[index]['name'],
        description: maps[index]['description'],
        growZoneNumber: maps[index]['growZoneNumber'],
        wateringInterval: maps[index]['wateringInterval'],
        imageUrl: maps[index]['imageUrl'],
      ).toPlant();
    });
  }

  Future<Plant> getPlantById(String plantId) async {
    final db = database;
    final List<Map<String, dynamic>> maps = await db.query(
      'plants',
      where: 'plantId = ?',
      whereArgs: [plantId],
    );

    return PlantData(
      plantId: maps[0]['plantId'],
      name: maps[0]['name'],
      description: maps[0]['description'],
      growZoneNumber: maps[0]['growZoneNumber'],
      wateringInterval: maps[0]['wateringInterval'],
      imageUrl: maps[0]['imageUrl'],
    ).toPlant();
  }

  void insertPlant(Plant plant) async {
    final db = database;
    db.insert(
      "plants",
      PlantData.fromPlant(plant).toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> batchInsert(List<Plant> plantList) async {
    final db = database;
    final batch = db.batch();

    for (final Plant plant in plantList) {
      batch.insert(
        'plants',
        PlantData.fromPlant(plant).toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    await batch.commit();
  }
}
