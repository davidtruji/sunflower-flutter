import 'package:sunflower_flutter/data/datasource/local/local.dart';
import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/domain/repository/garden_planting_repository.dart';

class GardenPlantingRepositoryImpl extends GardenPlantingRepository {
  final Local local;

  GardenPlantingRepositoryImpl(this.local);

  @override
  Future<void> addPlantToGarden(GardenPlanting gardenPlanting) async {
    await local.insertGardenPlanting(gardenPlanting);
  }

  @override
  Future<bool> isAddedToGarden(String plantId) {
    return local.isAddedToGarden(plantId);
  }

  @override
  Future<List<GardenPlanting>> getPlantGardenPlantings() async {
    return await local.getGardenPlantings();
  }
}
