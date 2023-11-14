import 'package:flutter/foundation.dart' show immutable;

@immutable
class Plant {
  final String plantId;
  final String name;
  final String description;
  final int growZoneNumber;
  final int wateringInterval;
  final String imageUrl;

  const Plant({
    required this.plantId,
    required this.name,
    required this.description,
    required this.growZoneNumber,
    required this.wateringInterval,
    required this.imageUrl,
  });

  @override
  String toString() {
    return name;
  }

  Map<String, dynamic> toMap() {
    return {
      "plantId": plantId,
      "name": name,
      "description": description,
      "growZoneNumber": growZoneNumber,
      "wateringInterval": wateringInterval,
      "imageUrl": imageUrl,
    };
  }

  factory Plant.instance() {
    return const Plant(
        plantId: "",
        name: "",
        description: "",
        growZoneNumber: 0,
        wateringInterval: 0,
        imageUrl: "");
  }

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
        plantId: json["plantId"],
        name: json["name"],
        description: json["description"],
        growZoneNumber: json["growZoneNumber"],
        wateringInterval: json["wateringInterval"],
        imageUrl: json["imageUrl"]);
  }
}
