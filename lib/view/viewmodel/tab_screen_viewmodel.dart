import 'package:sunflower_flutter/domain/model/plant_garden_planting.dart';
import 'package:sunflower_flutter/domain/repository/garden_planting_repository.dart';
import 'package:sunflower_flutter/domain/repository/plant_repository.dart';

import '../../domain/model/plant.dart';
import '../navigator.dart' as nav;
import 'root_viewmodel.dart';

class TabScreenViewModel extends RootViewModel {
  final PlantRepository plantRepository;
  final GardenPlantingRepository gardenPlantingRepository;
  final nav.Navigator navigator;

  List<Plant> _plants = [];
  List<PlantGardenPlanting> _gardenPlantings = [];

  List<Plant> get plants => _plants;

  List<PlantGardenPlanting> get gardenPlantings => _gardenPlantings;

  TabScreenViewModel(
      this.gardenPlantingRepository, this.plantRepository, this.navigator);

  @override
  initialize() {
    getGardenPlantings();
    getPlants();
  }

  void getPlants() async {
    _plants = await plantRepository.getAllPlants();
    notify();
  }

  void getGardenPlantings() async {
    _gardenPlantings = await gardenPlantingRepository.getPlantGardenPlanting();
    notify();
  }

  void onPlantTap(String id)  {
    navigator.toPlantDetail(id);
  }
}
