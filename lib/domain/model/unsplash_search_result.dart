import 'package:sunflower_flutter/domain/model/unsplash_photo.dart';

class UnsplashSearchResult {
  int total;
  int totalPages;
  List<UnsplashPhoto> results;

  UnsplashSearchResult(
      {required this.total, required this.totalPages, required this.results});
}
