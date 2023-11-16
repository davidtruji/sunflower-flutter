

import 'package:sunflower_flutter/domain/model/plant.dart';

abstract class PlantRepository {
  Future<List<Plant>> getAllPlants();

  Future<Plant> getPlantById(String plantId);
}
