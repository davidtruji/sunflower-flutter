import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sunflower_flutter/di/locator.dart';
import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';
import 'package:sunflower_flutter/domain/repository/garden_planting_repository.dart';
import 'package:sunflower_flutter/domain/repository/plant_repository.dart';
import 'package:sunflower_flutter/view/navigator.dart' as nav;
import 'package:sunflower_flutter/view/viewmodel/root_viewmodel.dart';
import 'package:sunflower_flutter/view/viewmodel/tab_screen_viewmodel.dart';

class PlantDetailViewModel extends RootViewModel {
  final PlantRepository plantRepository;
  final GardenPlantingRepository gardenPlantingRepository;
  final nav.Navigator navigator;

  Plant? plant;
  bool addedToGarden = true;

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

  void onTapShare(String plantName) {
    Share.share(
        "Revisa la planta $plantName en la aplicación multiplataforma de Sunflower");
  }

  void addPlantToGarden() async {
    DateTime dateNow = DateTime.now();
    DateFormat formatter = DateFormat("MMM d, y");

    await gardenPlantingRepository.addPlantToGarden(GardenPlanting(
        gardenPlantingId: plant!.plantId,
        plantId: plant!.plantId,
        name: plant!.name,
        plantDate: formatter.format(dateNow),
        lastWateringDate: formatter.format(dateNow),
        wateringInterval: plant!.wateringInterval,
        imageUrl: plant!.imageUrl));

    addedToGarden = true;
    notify();
    getIt<TabScreenViewModel>().getGardenPlantings();
  }
}
