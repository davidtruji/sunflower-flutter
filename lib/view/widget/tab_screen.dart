import 'package:flutter/material.dart';
import 'package:sunflower_flutter/di/locator.dart';
import 'package:sunflower_flutter/view/viewmodel/tab_screen_viewmodel.dart';
import 'package:sunflower_flutter/view/widget/garden_list.dart';
import 'package:sunflower_flutter/view/widget/plant_list.dart';
import 'package:sunflower_flutter/view/widget/root_widget.dart';

class TabScreen extends RootWidget<TabScreenViewModel> {
  TabScreen({super.key}) : super(getIt());

  @override
  Widget widget(TabScreenViewModel model, BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Sunflower'),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Visibility(
                    visible: model.filterVisibility,
                    child: IconButton(
                        onPressed: () => model.onTapFilter(),
                        icon: const Icon(Icons.filter_list))))
          ],
          bottom: TabBar(
            onTap: (tabIndex) => model.onTapTab(tabIndex),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
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
            gardenList(model.gardenPlantings, model.onPlantTap, context),
            plantList(model.plants, model.onPlantTap, context)
          ],
        ),
      ),
    );
  }
}
