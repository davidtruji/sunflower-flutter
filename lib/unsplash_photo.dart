import 'package:sunflower_flutter/unsplash_user.dart';

class UnsplashPhoto {
  String? id;
  Urls? urls;
  User? user;

  UnsplashPhoto({
    this.id,
    this.urls,
    this.user,
  });

  UnsplashPhoto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urls = json['urls'] != null ? Urls.fromJson(json['urls']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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
