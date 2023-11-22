import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';
import 'package:sunflower_flutter/domain/repository/garden_planting_repository.dart';
import 'package:sunflower_flutter/domain/repository/plant_repository.dart';
import 'package:sunflower_flutter/view/navigator.dart' as nav;
import 'package:sunflower_flutter/view/viewmodel/root_viewmodel.dart';

class TabScreenViewModel extends RootViewModel {
  final PlantRepository plantRepository;
  final GardenPlantingRepository gardenPlantingRepository;
  final nav.Navigator navigator;

  bool _filtered = false;
  List<Plant> _plants = [];
  List<Plant> _plantsFullList = [];
  List<GardenPlanting> _gardenPlantings = [];

  List<Plant> get plants => _plants;

  List<GardenPlanting> get gardenPlantings => _gardenPlantings;

  TabScreenViewModel(
      this.gardenPlantingRepository, this.plantRepository, this.navigator);

  @override
  initialize() {
    getGardenPlantings();
    getPlants();
  }

  void getPlants() async {
    _plants = await plantRepository.getAllPlants();
    _plantsFullList = List<Plant>.from(_plants);
    notify();
  }

  void onTapFilter() {
    _filtered = !_filtered;

    if (_filtered) {
      _plants =
          _plants.where((element) => element.growZoneNumber == 9).toList();
    } else {
      _plants = List<Plant>.from(_plantsFullList);
    }

    notify();
  }

  void getGardenPlantings() async {
    _gardenPlantings = await gardenPlantingRepository.getPlantGardenPlantings();
    notify();
  }

  void onPlantTap(String id) {
    navigator.toPlantDetail(id);
  }
}
