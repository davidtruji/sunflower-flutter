import 'package:sunflower_flutter/data/model/garden_planting_data.dart';
import 'package:sunflower_flutter/data/model/plant_data.dart';

class PlantGardenPlantingData {
  final PlantData plant;
  final GardenPlantingData gardenPlanting;

  const PlantGardenPlantingData(
      {required this.plant, required this.gardenPlanting});
}
