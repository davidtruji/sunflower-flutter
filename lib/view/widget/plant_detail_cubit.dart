import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';
import 'package:sunflower_flutter/domain/repository/garden_planting_repository.dart';
import 'package:sunflower_flutter/domain/repository/plant_repository.dart';
import 'package:sunflower_flutter/view/widget/plant_detail_state.dart';

class PlantDetailCubit extends Cubit<PlantDetailState> {
  PlantDetailCubit(this._plantRepository, this._gardenPlantingRepository)
      : super(PlantDetailState.empty());

  final PlantRepository _plantRepository;
  final GardenPlantingRepository _gardenPlantingRepository;

  void initialize(String plantId) async {
    Plant plant = await _getPlant(plantId);
    bool addedToGarden = await _getAddedToGarden(plantId);
    emit(PlantDetailState(plant: plant, addedToGarden: addedToGarden));
  }

  Future<Plant> _getPlant(String id) async {
    return _plantRepository.getPlantById(id);
  }

  Future<bool> _getAddedToGarden(String plantId) async {
    return _gardenPlantingRepository.isAddedToGarden(plantId);
  }

  void onTapShare(String plantName) {
    Share.share(
        "Revisa la planta $plantName en la aplicación multiplataforma de Sunflower");
  }

  void addPlantToGarden() async {
    DateTime dateNow = DateTime.now();
    DateFormat formatter = DateFormat("MMM d, y");

    await _gardenPlantingRepository.addPlantToGarden(GardenPlanting(
        gardenPlantingId: state.plant!.plantId,
        plantId: state.plant!.plantId,
        name: state.plant!.name,
        plantDate: formatter.format(dateNow),
        lastWateringDate: formatter.format(dateNow),
        wateringInterval: state.plant!.wateringInterval,
        imageUrl: state.plant!.imageUrl));

    emit(state.copyWith(addedToGarden: true));
  }
}
