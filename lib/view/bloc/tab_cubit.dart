import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';
import 'package:sunflower_flutter/domain/repository/garden_planting_repository.dart';
import 'package:sunflower_flutter/domain/repository/plant_repository.dart';
import 'package:sunflower_flutter/view/bloc/tab_state.dart';

class TabCubit extends Cubit<TabState> {
  static const gardenPlantingsTab = 0;
  static const plantsTab = 1;

  TabCubit(this._plantRepository, this._gardenPlantingRepository)
      : super(TabState.empty());

  final PlantRepository _plantRepository;
  final GardenPlantingRepository _gardenPlantingRepository;

  Future<void> initialize() async {
    state.gardenPlantings = await _getGardenPlantings();
    state.plantsFullList = await _getPlants();
    state.plants = List.of(state.plantsFullList);
    emit(state);
  }

  Future<List<GardenPlanting>> _getGardenPlantings() {
    return _gardenPlantingRepository.getPlantGardenPlantings();
  }

  Future<List<Plant>> _getPlants() async {
    return await _plantRepository.getAllPlants();
  }

  void onTapFilter() {
    bool filtered = !state.filtered;

    if (filtered) {
      state.plants =
          state.plants.where((element) => element.growZoneNumber == 9).toList();
    } else {
      state.plants = List<Plant>.from(state.plantsFullList);
    }

    emit(state.copyWith(filtered: filtered));
  }

  void updateGardenPlantings() async {
    state.gardenPlantings = await _getGardenPlantings();
    emit(state.copyWith());
  }

  void onTabChange(int newTabIndex) {
    bool filterVisibility = (newTabIndex == plantsTab);
    emit(state.copyWith(filterVisibility: filterVisibility));
  }

  void onPlantTap(String id) {
    //_navigator.toPlantDetail(id);
  }
}
