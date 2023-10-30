import 'package:flutter/material.dart';
import 'package:sunflower_flutter/my_garden_screen.dart';
import 'package:sunflower_flutter/plant_list_screen.dart';

void main() => runApp(const TabBarApp());

class TabBarApp extends StatelessWidget {
  const TabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: const Color(0xFF256F00))),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
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
        body: TabBarView(
          children: <Widget>[
            MyGardenScreen(),
            PlantListScreen(),
          ],
        ),
      ),
    );
  }
}
