class User {
  String? username;
  String? name;

  User({
    this.username,
    this.name,
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['name'] = name;
    return data;
  }
}
