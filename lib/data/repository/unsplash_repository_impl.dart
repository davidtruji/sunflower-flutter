import 'package:sunflower_flutter/data/datasource/remote/remote.dart';
import 'package:sunflower_flutter/domain/model/unsplash_search_result.dart';
import 'package:sunflower_flutter/domain/repository/unsplash_repository.dart';

class UnsplashRepositoryImpl extends UnsplashRepository {
  final Remote remote;

  UnsplashRepositoryImpl(this.remote);

  @override
  Future<UnsplashSearchResult> fetchGallery(String query, int page) {
    return remote.fetchGallery(query, page);
  }
}
