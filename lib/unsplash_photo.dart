import 'package:sunflower_flutter/unsplash_user.dart';

class UnsplashPhoto {
  final String id;
  final String unsplashPhotoUrl;
  final UnsplashUser user;

  UnsplashPhoto(
      {required this.id, required this.unsplashPhotoUrl, required this.user});

  factory UnsplashPhoto.fromJson(Map<String, dynamic> json) {
    return UnsplashPhoto(
      id: json["plantId"],
      unsplashPhotoUrl: json["name"],
      user: json["description"],
    );
  }
}
