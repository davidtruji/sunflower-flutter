import 'package:flutter/material.dart';
import 'package:sunflower_flutter/plant_list_item.dart';

class PlantListScreen extends StatelessWidget {
   PlantListScreen({
    super.key,
  });

  late List<PlantListItem> plantList=[];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 100; i++) {
      plantList.add( const PlantListItem());
    }

    return GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: plantList);
  }
}
