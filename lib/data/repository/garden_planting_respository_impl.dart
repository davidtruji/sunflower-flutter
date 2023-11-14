import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/domain/model/plant_garden_planting.dart';
import 'package:sunflower_flutter/domain/repository/garden_planting_repository.dart';

import '../datasource/local/local.dart';

class GardenPlantingRepositoryImpl extends GardenPlantingRepository {
  final Local local;

  GardenPlantingRepositoryImpl(this.local);

  @override
  Future<List<PlantGardenPlanting>> getPlantGardenPlanting() {
    return local.getPlantGardenPlanting();
  }

  @override
  void addPlantToGarden(GardenPlanting gardenPlanting) {
    local.insertGardenPlanting(gardenPlanting);
  }
}
