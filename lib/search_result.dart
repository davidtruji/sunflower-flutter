class SearchResults {
  int? total;
  int? totalPages;
  List<Results>? results;

  SearchResults({this.total, this.totalPages, this.results});

  SearchResults.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
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

class Results {
  String? id;
  Urls? urls;
  User? user;

  Results({
    this.id,
    this.urls,
    this.user,
  });

  Results.fromJson(Map<String, dynamic> json) {
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