import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';

class PlantGardenPlanting {
  final Plant plant;
  final GardenPlanting gardenPlanting;

  const PlantGardenPlanting(
      {required this.plant, required this.gardenPlanting});
}
