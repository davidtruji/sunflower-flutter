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

  Plant? plant; //TODO: Avoid exception not initialized

  // String get plantId => _plant!.plantId;
  //
  // String get name => _plant!.name;
  //
  // String get description => _plant!.description;
  //
  // int get growZoneNumber => _plant!.growZoneNumber;
  //
  // int get wateringInterval => _plant!.wateringInterval;
  //
  // String get imageUrl => _plant!.imageUrl;

  PlantDetailViewModel(
    this.plantRepository,
    this.gardenPlantingRepository,
    this.navigator,
  );

  @override
  initialize() {}

  Future<void> onDetailIdFound(String plantId) async {
    await getPlant(plantId);
  }

  Future<void> getPlant(String id) async {
    plant = await plantRepository.getPlantById(id);
    notify();
  }

  void onTapBack() {
    navigator.back();
  }

  void onTapGallery() {
    navigator.toGallery(plant!.name);
  }

  void addPlantToGarden() {
    DateTime dateNow = DateTime.now();
    DateFormat formatter = DateFormat("MMM d, y");
    // TODO: ADD PLANT

    gardenPlantingRepository.addPlantToGarden(GardenPlanting(
        gardenPlantingId: plant!.plantId,
        plantId: plant!.plantId,
        plantDate: formatter.format(dateNow),
        lastWateringDate: formatter.format(dateNow)));

    getIt<TabScreenViewModel>().getGardenPlantings();
  }
}
