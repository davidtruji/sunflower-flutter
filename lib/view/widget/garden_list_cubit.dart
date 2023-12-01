import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunflower_flutter/domain/model/garden_planting.dart';
import 'package:sunflower_flutter/domain/repository/garden_planting_repository.dart';
import 'package:sunflower_flutter/view/navigator.dart' as nav;

class GardenListCubit extends Cubit<List<GardenPlanting>> {
  GardenListCubit(this._repository, this._navigator) : super([]);

  final GardenPlantingRepository _repository;
  final nav.Navigator _navigator;

  void loadGardenPlantings() async {
    List<GardenPlanting> newState = await _repository.getPlantGardenPlantings();
    emit(newState);
  }

  void onGardenPlantingTap(String id) {
    _navigator.toPlantDetail(id);
  }

}
