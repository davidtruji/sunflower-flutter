import 'package:flutter/material.dart';
import 'package:sunflower_flutter/my_garden_screen.dart';
import 'package:sunflower_flutter/plant_list_screen.dart';
import 'package:sunflower_flutter/color_schemes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      home: TabScreen(0),
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
    );
  }
}

// ignore: must_be_immutable
class TabScreen extends StatelessWidget {
  int selectedPage;
  TabScreen(this.selectedPage, {super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: selectedPage,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Sunflower',
              style: Theme.of(context).textTheme.displaySmall),
          bottom: const TabBar(
            tabs: <Widget>[
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
        body: const TabBarView(
          children: <Widget>[
            MyGardenScreen(),
            PlantListScreen(),
          ],
        ),
      ),
    );
  }
}
