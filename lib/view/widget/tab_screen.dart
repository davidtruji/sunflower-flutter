import 'package:flutter/material.dart';
import 'package:sunflower_flutter/view/viewmodel/tab_screen_viewmodel.dart';
import 'package:sunflower_flutter/view/widget/garden_list.dart';

import '../../di/locator.dart';
import 'plant_list.dart';
import 'root_widget.dart';

class TabScreen extends RootWidget<TabScreenViewModel> {
  TabScreen({super.key}) : super(getIt());

  @override
  Widget widget(TabScreenViewModel model, BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Sunflower'),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
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
            gardenList(model.gardenPlantings, model.onPlantTap),
            plantList(model.plants, model.onPlantTap)
          ],
        ),
      ),
    );
  }
}
