import 'package:sunflower_flutter/domain/repository/unsplash_repository.dart';
import 'package:sunflower_flutter/view/viewmodel/root_viewmodel.dart';

import '../navigator.dart' as nav;

class GalleryViewModel extends RootViewModel {
  final UnsplashRepository unsplashRepository;
  final nav.Navigator navigator;

  late String _query = "";

  String get query => _query;

  GalleryViewModel(
    this.unsplashRepository,
    this.navigator,
  );

  @override
  initialize() {
    // TODO: implement initialize
  }

  void setQuery(String query) {
    _query = query;
  }

// void getPlants() async {
//   _plants = await unsplashRepository.fetchGallery(query, page);
//   notify();
// }
}
