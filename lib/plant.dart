import 'package:flutter/foundation.dart' show immutable;

@immutable
class Plant {
  final String plantId;
  final String name;
  final String description;
  final int growZoneNumber;
  final int wateringInterval;

  const Plant({
    required this.plantId,
    required this.name,
    required this.description,
    required this.growZoneNumber,
    required this.wateringInterval,
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
    };
  }
}
