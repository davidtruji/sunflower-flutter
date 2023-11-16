import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/view/widget/garden_list_item.dart';


Widget gardenList(
    List<GardenPlanting> gardenPlantings, Function onTap, BuildContext context) {
  List<GardenListItem> gardenPlantingsList = [];

  for (GardenPlanting g in gardenPlantings) {
    gardenPlantingsList.add(GardenListItem(
      gardenPlanting: g,
      onTap: () => onTap(g.plantId),
    ));
  }

  return gardenPlantings.isNotEmpty
      ? ResponsiveGridList(
          minItemWidth: 150,
          verticalGridMargin: 16,
          verticalGridSpacing: 16,
          horizontalGridMargin: 16,
          horizontalGridSpacing: 16,
          children: gardenPlantingsList,
        )
      : Center(
          child: Text(
            "Tu jardín esta vacío",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        );
}
