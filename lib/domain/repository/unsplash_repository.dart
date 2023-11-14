import '../model/unsplash_search_result.dart';

abstract class UnsplashRepository {
  Future<UnsplashSearchResults> fetchGallery(String query, int page);
}
