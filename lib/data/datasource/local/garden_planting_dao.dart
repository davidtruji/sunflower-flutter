import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sunflower_flutter/data/model/garden_planting_data.dart';
import 'package:sunflower_flutter/domain/model/garden_planting.dart';

class GardenPlantingDao {
  final Database database;

  GardenPlantingDao(this.database);

  Future<List<GardenPlantingData>> getGardenPlantings() async {
    final db = database;
    final List<Map<String, dynamic>> maps = await db.query('garden_plantings');

    return List.generate(maps.length, (index) {
      return GardenPlantingData(
        gardenPlantingId: maps[index]['gardenPlantingId'],
        plantId: maps[index]['plantId'],
        plantDate: maps[index]['plantDate'],
        lastWateringDate: maps[index]['lastWateringDate'],
      );
    });
  }

  Future<void> insertGardenPlanting(GardenPlanting gardenPlanting) async {
    final db = database;
    GardenPlantingData gardenPlantingData =
        GardenPlantingData.fromGardenPlanting(gardenPlanting);
    await db.insert(
      "garden_plantings",
      gardenPlantingData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<bool> isAddedToGarden(String plantId) async {
    final db = database;
    final List<Map<String, dynamic>> maps = await db.query(
      'garden_plantings',
      where: 'plantId = ?',
      whereArgs: [plantId],
    );

    return maps.isNotEmpty;
  }
}
