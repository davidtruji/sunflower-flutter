import 'package:sunflower_flutter/domain/model/unsplash_search_result.dart';
import 'package:sunflower_flutter/domain/repository/unsplash_repository.dart';
import 'package:sunflower_flutter/view/navigator.dart' as nav;
import 'package:sunflower_flutter/view/viewmodel/root_viewmodel.dart';

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
  initialize() {}

  void setQuery(String query) {
    _query = query;
  }

  Future<UnsplashSearchResult> fetchGallery(query, page) async {
    return await unsplashRepository.fetchGallery(query, page);
  }
}
