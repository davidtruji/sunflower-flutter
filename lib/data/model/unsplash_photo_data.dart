import 'package:sunflower_flutter/data/model/unsplash_user_data.dart';
import 'package:sunflower_flutter/domain/model/unsplash_photo.dart';

class UnsplashPhotoData {
  String? id;
  Urls? urls;
  UnsplashUserData? user;

  UnsplashPhotoData({
    this.id,
    this.urls,
    this.user,
  });

  UnsplashPhoto toUnsplashPhoto() {
    return UnsplashPhoto(
        id: id!, urls: Uri.parse(urls!.small!), user: user!.toUnsplashUser());
  }

  UnsplashPhotoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urls = json['urls'] != null ? Urls.fromJson(json['urls']) : null;
    user =
        json['user'] != null ? UnsplashUserData.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;

    if (urls != null) {
      data['urls'] = urls!.toJson();
    }

    if (user != null) {
      data['user'] = user!.toJson();
    }

    return data;
  }
}

class Urls {
  String? small;

  Urls({
    this.small,
  });

  Urls.fromJson(Map<String, dynamic> json) {
    small = json['small'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['small'] = small;
    return data;
  }
}
