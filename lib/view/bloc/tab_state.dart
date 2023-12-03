import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';

class TabState {
  bool filterVisibility = true;
  bool filtered = false;
  List<Plant> plants = [];
  List<Plant> plantsFullList = [];
  List<GardenPlanting> gardenPlantings = [];

  TabState(
      {required this.filterVisibility,
      required this.filtered,
      required this.plantsFullList,
      required this.gardenPlantings,
      required this.plants});

  TabState.empty();

  TabState copyWith(
      {bool? filterVisibility,
      bool? filtered,
      List<Plant>? plantsFullList,
      List<Plant>? plants,
      List<GardenPlanting>? gardenPlantings}) {
    return TabState(
        filterVisibility: filterVisibility ?? this.filterVisibility,
        filtered: filtered ?? this.filtered,
        plantsFullList: plantsFullList ?? this.plantsFullList,
        plants: plants ?? this.plants,
        gardenPlantings: gardenPlantings ?? this.gardenPlantings);
  }
}
