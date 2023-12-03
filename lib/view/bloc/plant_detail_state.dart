import 'package:sunflower_flutter/domain/model/plant.dart';

final class PlantDetailState {
  Plant? plant;
  bool addedToGarden = true;

  PlantDetailState({required this.plant, required this.addedToGarden});

  PlantDetailState.empty();

  PlantDetailState copyWith({Plant? plant, bool? addedToGarden}) {
    return PlantDetailState(
      plant: plant ?? this.plant,
      addedToGarden: addedToGarden ?? this.addedToGarden,
    );
  }
}
