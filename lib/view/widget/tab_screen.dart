import 'package:flutter/material.dart';
import 'package:sunflower_flutter/di/locator.dart';
import 'package:sunflower_flutter/view/viewmodel/tab_screen_viewmodel.dart';
import 'package:sunflower_flutter/view/widget/garden_list.dart';
import 'package:sunflower_flutter/view/widget/plant_list.dart';
import 'package:sunflower_flutter/view/widget/root_widget.dart';
import 'package:sunflower_flutter/view/widget/shape.dart';

class TabScreen extends MyRootWidget<TabScreenViewModel> {
  TabScreen({super.key}) : super(getIt());

  @override
  Widget widget(TabScreenViewModel model, BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Builder(
          builder: (context) {
            final TabController controller = DefaultTabController.of(context);
            controller.addListener(() {
              if (!controller.indexIsChanging) {
                model.onTabChange(controller.index);
              }
            });
            return Scaffold(
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
                  model.gardenPlantings.isNotEmpty
                      ? gardenList(
                          model.gardenPlantings, model.onPlantTap, context)
                      : nothingPlanted(context, controller),
                  plantList(model.plants, model.onPlantTap, context)
                ],
              ),
            );
          },
        ));
  }

  Widget nothingPlanted(BuildContext context, TabController controller) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Tu jardín esta vacío",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          FilledButton(
            style: ButtonStyle(shape: Shape.filledButtonShape),
            onPressed: () => controller.animateTo(1),
            child: const Text("Añadir planta"),
          )
        ]);
  }
}
