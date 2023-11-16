import 'package:sunflower_flutter/domain/model/garden_planting.dart';

abstract class GardenPlantingRepository {
  Future<List<GardenPlanting>> getPlantGardenPlantings();

  Future<void> addPlantToGarden(GardenPlanting gardenPlanting);

  Future<bool> isAddedToGarden(String plantId);
}
