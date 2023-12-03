import 'package:sunflower_flutter/domain/model/unsplash_photo.dart';

class UnsplashSearchResult {
  int total = 0;
  int totalPages = 0;
  List<UnsplashPhoto> results = [];

  UnsplashSearchResult(
      {required this.total, required this.totalPages, required this.results});

  UnsplashSearchResult.empty();
}
