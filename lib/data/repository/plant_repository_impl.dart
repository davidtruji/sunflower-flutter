import 'package:sunflower_flutter/domain/model/plant.dart';
import 'package:sunflower_flutter/domain/repository/plant_repository.dart';

import '../datasource/local/local.dart';

class PlantRepositoryImpl extends PlantRepository {
  final Local local;

  PlantRepositoryImpl(this.local);

  @override
  Future<List<Plant>> getAllPlants() {
    return local.getAllPlants();
  }

  @override
  Future<Plant> getPlantById(String plantId) {
    return local.getPlantById(plantId);
  }
}
