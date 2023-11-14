import '../../../domain/model/unsplash_search_result.dart';

abstract class Remote {
  Future<UnsplashSearchResults> fetchGallery(String query, int page);
}
