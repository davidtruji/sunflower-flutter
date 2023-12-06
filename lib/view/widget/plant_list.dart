import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';
import 'package:sunflower_flutter/view/bloc/plant_detail_cubit.dart';
import 'package:sunflower_flutter/view/widget/plant_detail_screen.dart';
import 'package:sunflower_flutter/view/widget/plant_list_item.dart';

Widget plantList(List<Plant> plants, BuildContext context) {
  List<PlantListItem> plantList = [];

  for (Plant p in plants) {
    plantList.add(PlantListItem(
      plant: p,
      onTap: () => {
        // Event to plant detail
        context.read<PlantDetailCubit>().setPlant(plantId: p.plantId),

        // Navigate to widget
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
    children: plantList,
  );
}
