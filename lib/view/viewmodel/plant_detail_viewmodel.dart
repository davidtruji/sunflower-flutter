import 'package:intl/intl.dart';
import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/domain/repository/garden_planting_repository.dart';
import 'package:sunflower_flutter/view/viewmodel/root_viewmodel.dart';
import 'package:sunflower_flutter/view/viewmodel/tab_screen_viewmodel.dart';

import '../../di/locator.dart';
import '../../domain/model/plant.dart';
import '../../domain/repository/plant_repository.dart';
import '../navigator.dart' as nav;

class PlantDetailViewModel extends RootViewModel {
  final PlantRepository plantRepository;
  final GardenPlantingRepository gardenPlantingRepository;
  final nav.Navigator navigator;

  Plant? plant;
  late bool addedToGarden;

  PlantDetailViewModel(
    this.plantRepository,
    this.gardenPlantingRepository,
    this.navigator,
  );

  @override
  initialize() {}

  Future<void> onDetailIdFound(String plantId) async {
    await _getPlant(plantId);
    await _getAddedToGarden(plantId);
    notify();
  }

  Future<void> _getPlant(String id) async {
    plant = await plantRepository.getPlantById(id);
  }

  Future<void> _getAddedToGarden(String plantId) async {
    addedToGarden = await gardenPlantingRepository.isAddedToGarden(plantId);
  }

  void onTapBack() {
    navigator.back();
  }

  void onTapGallery() {
    navigator.toPlantGallery(plant!.name);
  }

  void addPlantToGarden() async {
    DateTime dateNow = DateTime.now();
    DateFormat formatter = DateFormat("MMM d, y");

    await gardenPlantingRepository.addPlantToGarden(GardenPlanting(
        gardenPlantingId: plant!.plantId,
        plantId: plant!.plantId,
        plantDate: formatter.format(dateNow),
        lastWateringDate: formatter.format(dateNow)));

    addedToGarden = true;
    notify();
    getIt<TabScreenViewModel>().getGardenPlantings();
  }
}
