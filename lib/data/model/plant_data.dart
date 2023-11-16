import 'package:flutter/foundation.dart' show immutable;
import 'package:sunflower_flutter/domain/model/plant.dart';

@immutable
class PlantData {
  final String plantId;
  final String name;
  final String description;
  final int growZoneNumber;
  final int wateringInterval;
  final String imageUrl;

  const PlantData({
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

  factory PlantData.fromPlant(Plant plant) {
    return PlantData(
        plantId: plant.plantId,
        name: plant.name,
        description: plant.description,
        growZoneNumber: plant.growZoneNumber,
        wateringInterval: plant.wateringInterval,
        imageUrl: plant.imageUrl);
  }

  Plant toPlant() {
    return Plant(
        plantId: plantId,
        name: name,
        description: description,
        growZoneNumber: growZoneNumber,
        wateringInterval: wateringInterval,
        imageUrl: imageUrl);
  }

  factory PlantData.fromJson(Map<String, dynamic> json) {
    return PlantData(
        plantId: json["plantId"],
        name: json["name"],
        description: json["description"],
        growZoneNumber: json["growZoneNumber"],
        wateringInterval: json["wateringInterval"],
        imageUrl: json["imageUrl"]);
  }
}
