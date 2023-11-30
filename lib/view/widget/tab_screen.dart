import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunflower_flutter/di/locator.dart';
import 'package:sunflower_flutter/view/widget/plan_list_cubit.dart';
import 'package:sunflower_flutter/view/widget/tab_view.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlantListCubit(getIt())..loadPlants(),
      child: const TabScreenView(),
    );
  }
}
