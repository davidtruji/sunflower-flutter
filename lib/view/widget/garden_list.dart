import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/view/widget/garden_list_item.dart';
import 'package:sunflower_flutter/view/widget/navigator_cubit.dart';
import 'package:sunflower_flutter/view/widget/plant_detail_cubit.dart';

Widget gardenList(List<GardenPlanting> gardenPlantings, BuildContext context) {
  List<GardenListItem> gardenPlantingsList = [];

  for (GardenPlanting g in gardenPlantings) {
    gardenPlantingsList.add(GardenListItem(
      gardenPlanting: g,
      onTap: () => {
        // Event to plant detail BLOC
        context.read<PlantDetailCubit>().initialize(g.plantId),
        // Event to navigator BLOC
        context.read<NavigatorCubit>().toPlantDetail()
      },
    ));
  }

  return ResponsiveGridList(
    minItemWidth: 150,
    verticalGridMargin: 16,
    verticalGridSpacing: 16,
    horizontalGridMargin: 16,
    horizontalGridSpacing: 16,
    children: gardenPlantingsList,
  );
}
