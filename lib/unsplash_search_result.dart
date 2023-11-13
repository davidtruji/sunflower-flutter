import 'package:sunflower_flutter/unsplash_photo.dart';

class UnsplashSearchResults {
  int? total;
  int? totalPages;
  List<UnsplashPhoto>? results;

  UnsplashSearchResults({this.total, this.totalPages, this.results});

  UnsplashSearchResults.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = <UnsplashPhoto>[];
      json['results'].forEach((v) {
        results!.add(UnsplashPhoto.fromJson(v));
      });
    }
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
