import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';
import 'package:sunflower_flutter/domain/repository/garden_planting_repository.dart';
import 'package:sunflower_flutter/domain/repository/plant_repository.dart';
import 'package:sunflower_flutter/view/navigator.dart' as nav;

class PlantDetailCubit extends Cubit<Plant?> {
  PlantDetailCubit(
      this._plantRepository, this._gardenPlantingRepository, this._navigator)
      : super(null);

  final PlantRepository _plantRepository;
  final GardenPlantingRepository _gardenPlantingRepository;
  final nav.Navigator _navigator;

  Future<Plant> _getPlant(String id) async {
    return await _plantRepository.getPlantById(id);
  }

  void onDetailIdFound(String plantId) async {
    Plant newState = await _getPlant(plantId);
    //await _getAddedToGarden(plantId);
    emit(newState);
  }
}
