import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/view/bloc/plant_detail_cubit.dart';
import 'package:sunflower_flutter/view/widget/garden_list_item.dart';
import 'package:sunflower_flutter/view/widget/plant_detail_screen.dart';

Widget gardenList(List<GardenPlanting> gardenPlantings, BuildContext context) {
  List<GardenListItem> gardenPlantingsList = [];

  for (GardenPlanting g in gardenPlantings) {
    gardenPlantingsList.add(GardenListItem(
      gardenPlanting: g,
      onTap: () => {
        // Event to plant detail BLOC
        context.read<PlantDetailCubit>().setPlant(plantId: g.plantId),

        // Navigate to detail
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PlantDetailScreen(),
        )),
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
