import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunflower_flutter/domain/model/plant.dart';
import 'package:sunflower_flutter/domain/repository/plant_repository.dart';

class PlantListCubit extends Cubit<List<Plant>> {
  PlantListCubit(this._repository) : super([]);

  final PlantRepository _repository;

  void loadPlants() async {
    List<Plant> newState = await _repository.getAllPlants();
    emit(newState);
  }
}
