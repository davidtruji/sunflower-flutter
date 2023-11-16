import 'package:sunflower_flutter/domain/model/unsplash_search_result.dart';

abstract class Remote {
  Future<UnsplashSearchResult> fetchGallery(String query, int page);
}
