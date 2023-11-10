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

  static final tabScreenKey = GlobalKey<TabScreenState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      home: TabScreen(key: tabScreenKey),
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
    );
  }
}

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  TabScreenState createState() => TabScreenState();
}

class TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text('Sunflower', style: Theme.of(context).textTheme.displaySmall),
        bottom: TabBar(
          controller: tabController,
          tabs: const <Widget>[
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
        controller: tabController,
        children: const <Widget>[
          MyGardenScreen(),
          PlantListScreen(),
        ],
      ),
    );
  }
}
