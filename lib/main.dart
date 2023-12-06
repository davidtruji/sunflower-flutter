import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunflower_flutter/view/bloc/gallery_cubit.dart';
import 'package:sunflower_flutter/view/bloc/plant_detail_cubit.dart';
import 'package:sunflower_flutter/view/bloc/tab_cubit.dart';
import 'package:sunflower_flutter/view/color_schemes.dart';
import 'package:sunflower_flutter/view/widget/tab_screen.dart';

import 'di/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDI();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => TabCubit(getIt(), getIt())..initialize()),
    BlocProvider(create: (_) => PlantDetailCubit(getIt(), getIt())),
    BlocProvider(create: (_) => GalleryCubit(getIt()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      home: const TabScreen(),
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
    );
  }
}
