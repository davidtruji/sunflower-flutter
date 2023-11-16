import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';

abstract class Local {
  Future<List<Plant>> getAllPlants();

  Future<List<GardenPlanting>> getGardenPlantings();

  Future<void> insertGardenPlanting(GardenPlanting gardenPlanting);

  void batchPlantInsert(List<Plant> plantList);

  Future<Plant> getPlantById(String plantId);

  Future<bool> isAddedToGarden(String plantId);
}
