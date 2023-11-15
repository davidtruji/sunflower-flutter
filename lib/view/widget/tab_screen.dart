import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:sunflower_flutter/view/viewmodel/tab_screen_viewmodel.dart';
import 'package:sunflower_flutter/view/widget/plant_list_item.dart';

import '../../di/locator.dart';
import '../../domain/model/plant.dart';
import '../../domain/model/plant_garden_planting.dart';
import 'garden_list_item.dart';
import 'root_widget.dart';

class TabScreen extends RootWidget<TabScreenViewModel> {
  TabScreen({super.key}) : super(getIt());

  @override
  Widget widget(TabScreenViewModel model, BuildContext context) {
    debugPrint("TABSCREEN WIDGET");

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Sunflower'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.local_florist, size: 36),
                text: "Mi jardín",
              ),
              Tab(
                icon: Icon(Icons.eco, size: 36),
                text: "Lista de plantas",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            myGarden(model.gardenPLantings, model),
            plantList(model.plants, model)
          ],
        ),
      ),
    );
  }

  Widget myGarden(List<PlantGardenPlanting> plantGardenPlantings,
      TabScreenViewModel model) {
    List<GardenListItem> gardenPlantings = [];

    for (PlantGardenPlanting g in plantGardenPlantings) {
      gardenPlantings.add(GardenListItem(
        plantGardenPlanting: g,
        onTap: () => model.onPlantTap(g.plant.plantId),
      ));
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

  Widget plantList(List<Plant> plants, TabScreenViewModel model) {
    List<PlantListItem> plantList = [];

    for (Plant p in plants) {
      plantList.add(PlantListItem(
        plant: p,
        onTap: () => model.onPlantTap(p.plantId),
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
}
