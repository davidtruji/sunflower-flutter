import 'package:sunflower_flutter/domain/model/garden_planting.dart';

import '../model/plant_garden_planting.dart';

abstract class GardenPlantingRepository {
  Future<List<PlantGardenPlanting>> getPlantGardenPlanting();

  void addPlantToGarden(GardenPlanting gardenPlanting);
}
