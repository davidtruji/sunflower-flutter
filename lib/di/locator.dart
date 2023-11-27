import 'package:get_it/get_it.dart';
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
  SqliteLocal bdImpl = SqliteLocal();
  await bdImpl.initializeBD();

  // DATA
  getIt.registerSingleton<Local>(bdImpl);
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
