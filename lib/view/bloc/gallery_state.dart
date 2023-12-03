import 'package:sunflower_flutter/domain/model/unsplash_search_result.dart';

class GalleryState {
  String query = "";
  UnsplashSearchResult? unsplashSearchResult;
  int page = 0;

  GalleryState(
      {required this.query,
      required this.page,
      required this.unsplashSearchResult});

  GalleryState.empty();

  GalleryState copyWith(
      {String? query, int? page, UnsplashSearchResult? unsplashSearchResult}) {
    return GalleryState(
        query: query ?? this.query,
        page: page ?? this.page,
        unsplashSearchResult:
            unsplashSearchResult ?? this.unsplashSearchResult);
  }
}
