import 'package:sunflower_flutter/domain/model/unsplash_user.dart';

class UnsplashPhoto {
  String id;
  Uri urls;
  UnsplashUser user;

  UnsplashPhoto({
    required this.id,
    required this.urls,
    required this.user,
  });
}
