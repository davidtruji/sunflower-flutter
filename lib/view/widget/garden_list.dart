import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/view/bloc/navigator_cubit.dart';
import 'package:sunflower_flutter/view/bloc/plant_detail_cubit.dart';
import 'package:sunflower_flutter/view/widget/garden_list_item.dart';

Widget gardenList(List<GardenPlanting> gardenPlantings, BuildContext context) {
  List<GardenListItem> gardenPlantingsList = [];

  for (GardenPlanting g in gardenPlantings) {
    gardenPlantingsList.add(GardenListItem(
      gardenPlanting: g,
      onTap: () => {
        // Event to plant detail BLOC
        context.read<PlantDetailCubit>().setPlant(plantId: g.plantId),
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
