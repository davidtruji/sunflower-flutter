import 'package:flutter/foundation.dart' show immutable;
import 'package:sunflower_flutter/domain/model/garden_planting.dart';

@immutable
class GardenPlantingData {
  final String gardenPlantingId;
  final String plantId;
  final String plantDate;
  final String lastWateringDate;

  const GardenPlantingData({
    required this.gardenPlantingId,
    required this.plantId,
    required this.plantDate,
    required this.lastWateringDate,
  });

  @override
  String toString() {
    return plantId;
  }

  Map<String, dynamic> toMap() {
    return {
      "gardenPlantingId": gardenPlantingId,
      "plantId": plantId,
      "plantDate": plantDate,
      "lastWateringDate": lastWateringDate,
    };
  }

  factory GardenPlantingData.fromGardenPlanting(GardenPlanting gardenPlanting) {
    return GardenPlantingData(
      gardenPlantingId: gardenPlanting.gardenPlantingId,
      plantId: gardenPlanting.plantId,
      plantDate: gardenPlanting.plantDate,
      lastWateringDate: gardenPlanting.lastWateringDate,
    );
  }

  factory GardenPlantingData.fromJson(Map<String, dynamic> json) {
    return GardenPlantingData(
      gardenPlantingId: json["gardenPlantingId"],
      plantId: json["plantId"],
      plantDate: json["plantDate"],
      lastWateringDate: json["lastWateringDate"],
    );
  }
}
