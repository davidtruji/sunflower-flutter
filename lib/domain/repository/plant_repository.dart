import '../model/plant.dart';

abstract class PlantRepository {
  Future<List<Plant>> getAllPlants();

  Future<Plant> getPlantById(String plantId);
}
