import 'package:flutter/material.dart';
import 'package:sunflower_flutter/plant_list_item.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class MyGardenScreen extends StatelessWidget {
  MyGardenScreen({super.key});

  late List<PlantListItem> plantList = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 100; i++) {
      plantList.add(const PlantListItem());
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
}
