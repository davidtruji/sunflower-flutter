import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../domain/model/garden_planting.dart';

class GardenPlantingDao {
  final Database database;

  GardenPlantingDao(this.database);

  Future<List<GardenPlanting>> getGardenPlantings() async {
    final db = database;
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

  void insertGardenPlanting(GardenPlanting gardenPlanting) async {
    final db = database;
    db.insert(
      "garden_plantings",
      gardenPlanting.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
