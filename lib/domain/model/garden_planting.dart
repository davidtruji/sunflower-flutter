class GardenPlanting {
  final String gardenPlantingId;
  final String plantId;
  final String name;
  final int wateringInterval;
  final String imageUrl;
  final String plantDate;
  final String lastWateringDate;

  GardenPlanting(
      {required this.gardenPlantingId,
      required this.plantId,
      required this.name,
      required this.wateringInterval,
      required this.imageUrl,
      required this.plantDate,
      required this.lastWateringDate});
}
