import 'package:sunflower_flutter/domain/model/unsplash_search_result.dart';
import 'package:sunflower_flutter/domain/repository/unsplash_repository.dart';

import '../datasource/remote/remote.dart';

class UnsplashRepositoryImpl extends UnsplashRepository {
  final Remote remote;

  UnsplashRepositoryImpl(this.remote);

  @override
  Future<UnsplashSearchResults> fetchGallery(String query, int page) {
    return remote.fetchGallery(query, page);
  }
}
