import 'package:flutter/material.dart';
import 'package:sunflower_flutter/garden_list_item.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:sunflower_flutter/garden_planting.dart';
import 'package:sunflower_flutter/plant.dart';
import 'package:sunflower_flutter/plant_garden_planting.dart';
import 'package:sunflower_flutter/plant_garden_planting.dart';

import 'db_helper.dart';

class MyGardenScreen extends StatefulWidget {
  const MyGardenScreen({super.key});

  @override
  GardenListState createState() => GardenListState();
}

class GardenListState extends State<MyGardenScreen> {
  final DBHelper helper = DBHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PlantGardenPlanting>>(
        future: helper.getPlantGardenPlanting(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nothing planted yet'));
          } else {
            final plantGardenPlanting = snapshot.data;
            List<GardenListItem> gardenPlantings = [];

            for (PlantGardenPlanting g in plantGardenPlanting!) {
              gardenPlantings.add(GardenListItem(plantGardenPlanting: g));
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
        });
  }
}
