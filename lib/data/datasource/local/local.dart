import '../../../domain/model/garden_planting.dart';
import '../../../domain/model/plant.dart';
import '../../../domain/model/plant_garden_planting.dart';

abstract class Local {
  Future<List<Plant>> getAllPlants();

  Future<List<GardenPlanting>> getGardenPlantings();

  Future<List<PlantGardenPlanting>> getPlantGardenPlanting();

  Future<void> insertGardenPlanting(GardenPlanting gardenPlanting);

  void batchPlantInsert(List<Plant> plantList);

  Future<Plant> getPlantById(String plantId);
}
