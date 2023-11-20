import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sunflower_flutter/data/datasource/local/local.dart';
import 'package:sunflower_flutter/data/datasource/local/sqlite_local.dart';
import 'package:sunflower_flutter/data/datasource/remote/remote.dart';
import 'package:sunflower_flutter/data/datasource/remote/unsplash_api.dart';
import 'package:sunflower_flutter/data/repository/garden_planting_respository_impl.dart';
import 'package:sunflower_flutter/data/repository/plant_repository_impl.dart';
import 'package:sunflower_flutter/data/repository/unsplash_repository_impl.dart';
import 'package:sunflower_flutter/domain/repository/garden_planting_repository.dart';
import 'package:sunflower_flutter/domain/repository/plant_repository.dart';
import 'package:sunflower_flutter/domain/repository/unsplash_repository.dart';
import 'package:sunflower_flutter/view/navigator.dart' as nav;
import 'package:sunflower_flutter/view/viewmodel/gallery_viewmodel.dart';
import 'package:sunflower_flutter/view/viewmodel/plant_detail_viewmodel.dart';
import 'package:sunflower_flutter/view/viewmodel/tab_screen_viewmodel.dart';

final getIt = GetIt.I;

Future<void> initializeDI() async {
  await data();
  await domain();
  await view();
}

Future<void> data() async {
  final db = await getDataBase();

  // DATA
  getIt.registerSingleton<Local>(SqliteLocal(db));
  getIt.registerSingleton<Remote>(UnsplashAPI());
  getIt.registerSingleton<PlantRepository>(PlantRepositoryImpl(getIt.get()));
  getIt.registerSingleton<GardenPlantingRepository>(
      GardenPlantingRepositoryImpl(getIt.get()));
  getIt.registerSingleton<UnsplashRepository>(
      UnsplashRepositoryImpl(getIt.get()));
}

Future<void> domain() async {}

Future<void> view() async {
  getIt.registerSingleton<nav.Navigator>(nav.Navigator());
  getIt.registerSingleton<TabScreenViewModel>(
      TabScreenViewModel(getIt(), getIt(), getIt()));
  getIt.registerSingleton<PlantDetailViewModel>(
      PlantDetailViewModel(getIt(), getIt(), getIt()));
  getIt.registerSingleton<GalleryViewModel>(GalleryViewModel(getIt(), getIt()));
}

Future<Database> getDataBase() async {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentsDir.path, "Sunflower", "data.db");
    final winLinuxDB = await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: onCreateDataBase,
      ),
    );
    return winLinuxDB;
  } else if (Platform.isAndroid || Platform.isIOS) {
    final path = join(await getDatabasesPath(), "data.db");
    final iOSAndroidDB = await openDatabase(
      path,
      version: 1,
      onCreate: onCreateDataBase,
    );

    return iOSAndroidDB;
  }
  throw Exception("Unsupported platform");
}

Future<void> onCreateDataBase(Database database, int version) async {
  debugPrint("Creating database");
  final db = database;

  // Create plants table
  await db.execute(""" CREATE TABLE IF NOT EXISTS plants(
            plantId TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            growZoneNumber INTEGER,
            wateringInterval INTEGER,
            imageUrl TEXT
          )
 """);

  // Create garden table
  await db.execute(""" CREATE TABLE IF NOT EXISTS garden_plantings(
            gardenPlantingId TEXT PRIMARY KEY,
            plantId TEXT,
            plantDate TEXT,
            lastWateringDate TEXT
          )
 """);
}
