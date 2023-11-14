import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../domain/model/plant.dart';

class PlantDao {
  final Database database;

  PlantDao(this.database);

  Future<List<Plant>> getAllPlants() async {
    final db = database;
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

  Future<Plant> getPlantById(String plantId) async {
    final db = database;
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

  void insertPlant(Plant plant) async {
    final db = database;
    db.insert(
      "plants",
      plant.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  void batchInsert(List<Plant> plantList) async {
    final db = database;
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
}
