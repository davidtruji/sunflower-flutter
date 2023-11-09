import 'package:flutter/material.dart';
import 'package:sunflower_flutter/db_helper.dart';
import 'package:sunflower_flutter/plant.dart';
import 'package:sunflower_flutter/plant_list_item.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class PlantListScreen extends StatefulWidget {
  const PlantListScreen({super.key});

  @override
  PlantListState createState() => PlantListState();
}

class PlantListState extends State<PlantListScreen> {
  final DBHelper helper = DBHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Plant>>(
        future: helper.getAllPlants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found.'));
          } else {
            final plants = snapshot.data;
            List<PlantListItem> plantList = [];

            for (Plant p in plants!) {
              plantList.add(PlantListItem(plant: p));
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
        });
  }
}
