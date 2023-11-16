class Plant {
  final String plantId;
  final String name;
  final String description;
  final int growZoneNumber;
  final int wateringInterval;
  final String imageUrl;

  Plant(
      {required this.plantId,
      required this.name,
      required this.description,
      required this.growZoneNumber,
      required this.wateringInterval,
      required this.imageUrl});
}
