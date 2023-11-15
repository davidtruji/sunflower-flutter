import 'package:flutter/cupertino.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:sunflower_flutter/domain/model/plant_garden_planting.dart';

import 'garden_list_item.dart';

Widget gardenList(
    List<PlantGardenPlanting> plantGardenPlantings, Function onTap) {
  List<GardenListItem> gardenPlantings = [];

  for (PlantGardenPlanting g in plantGardenPlantings) {
    gardenPlantings.add(GardenListItem(
      plantGardenPlanting: g,
      onTap: () => onTap(g.plant.plantId),
    ));
  }

  return ResponsiveGridList(
    minItemWidth: 150,
    verticalGridMargin: 16,
    verticalGridSpacing: 16,
    horizontalGridMargin: 16,
    horizontalGridSpacing: 16,
    children: gardenPlantings,
  );
}
