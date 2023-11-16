import 'package:flutter/cupertino.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';
import 'package:sunflower_flutter/view/widget/plant_list_item.dart';


Widget plantList(List<Plant> plants, Function onTap, BuildContext context) {
  List<PlantListItem> plantList = [];

  for (Plant p in plants) {
    plantList.add(PlantListItem(
      plant: p,
      onTap: () => onTap(p.plantId),
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
