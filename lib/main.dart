import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunflower_flutter/view/widget/color_schemes.dart';
import 'package:sunflower_flutter/view/widget/gallery_screen.dart';
import 'package:sunflower_flutter/view/widget/navigator_cubit.dart';
import 'package:sunflower_flutter/view/widget/navigator_state.dart'
    as nav_state;
import 'package:sunflower_flutter/view/widget/plant_detail_cubit.dart';
import 'package:sunflower_flutter/view/widget/plant_detail_screen.dart';
import 'package:sunflower_flutter/view/widget/tab_cubit.dart';
import 'package:sunflower_flutter/view/widget/tab_screen.dart';

import 'di/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDI();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => NavigatorCubit()),
    BlocProvider(
        create: (_) => TabCubit(getIt(), getIt())..initialize()),
    BlocProvider(create: (_) => PlantDetailCubit(getIt(), getIt()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      home: BlocBuilder<NavigatorCubit, nav_state.NavigatorState>(
        builder: (_, state) {
          if (state is nav_state.ToTab) {
            return const TabScreen();
          } else if (state is nav_state.ToPlantDetail) {
            return const PlantDetailScreen();
          } else {
            return GalleryScreen();
          }
        },
      ),
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
    );
  }
}
