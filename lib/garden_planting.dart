import 'dart:ffi';

import 'package:flutter/foundation.dart' show immutable;

@immutable
class GardenPlanting {
  final int gardenPlantingId;
  final String plantId;
  final String plantDate;
  final String lastWateringDate;

  const GardenPlanting({
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

  factory GardenPlanting.fromJson(Map<String, dynamic> json) {
    return GardenPlanting(
      gardenPlantingId: json["gardenPlantingId"],
      plantId: json["plantId"],
      plantDate: json["plantDate"],
      lastWateringDate: json["lastWateringDate"],
    );
  }
}
