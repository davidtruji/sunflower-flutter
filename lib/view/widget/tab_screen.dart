import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunflower_flutter/di/locator.dart';
import 'package:sunflower_flutter/view/widget/garden_list.dart';
import 'package:sunflower_flutter/view/widget/plant_list.dart';
import 'package:sunflower_flutter/view/widget/shape.dart';
import 'package:sunflower_flutter/view/widget/tab_cubit.dart';
import 'package:sunflower_flutter/view/widget/tab_state.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabCubit>(
      create: (_) => TabCubit(getIt(), getIt(), getIt())..initialize(),
      child: const TabScreenView(),
    );
  }
}

class TabScreenView extends StatelessWidget {
  const TabScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabCubit, TabState>(builder: (context, state) {
      return DefaultTabController(
          initialIndex: 1,
          length: 2,
          child: Builder(builder: (context) {
            final TabController controller = DefaultTabController.of(context);
            controller.addListener(() {
              if (!controller.indexIsChanging &&
                  controller.previousIndex != controller.index) {
                context.read<TabCubit>().onTabChange(controller.index);
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
                          visible: state.filterVisibility,
                          child: IconButton(
                              onPressed: () =>
                                  context.read<TabCubit>().onTapFilter(),
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
                  state.gardenPlantings.isNotEmpty
                      ? gardenList(state.gardenPlantings,
                          context.read<TabCubit>().onPlantTap, context)
                      : nothingPlanted(context, controller),
                  plantList(state.plants, context.read<TabCubit>().onPlantTap,
                      context)
                ],
              ),
            );
          }));
    });
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
