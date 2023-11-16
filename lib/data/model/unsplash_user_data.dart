import 'package:sunflower_flutter/domain/model/unsplash_user.dart';

class UnsplashUserData {
  String? username;
  String? name;

  UnsplashUserData({
    this.username,
    this.name,
  });

  UnsplashUserData.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
  }

  UnsplashUser toUnsplashUser() {
    return UnsplashUser(username: username!, name: name!);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['name'] = name;
    return data;
  }
}
