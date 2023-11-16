import 'package:sunflower_flutter/data/model/unsplash_photo_data.dart';
import 'package:sunflower_flutter/domain/model/unsplash_search_result.dart';

class UnsplashSearchResultData {
  int? total;
  int? totalPages;
  List<UnsplashPhotoData>? results;

  UnsplashSearchResultData({this.total, this.totalPages, this.results});

  UnsplashSearchResultData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = <UnsplashPhotoData>[];
      json['results'].forEach((v) {
        results!.add(UnsplashPhotoData.fromJson(v));
      });
    }
  }

  UnsplashSearchResult toUnsplashSearchResult() {
    return UnsplashSearchResult(
      total: total!,
      totalPages: totalPages!,
      results: List.generate(results!.length, (index) => results![index].toUnsplashPhoto()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['total_pages'] = totalPages;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
