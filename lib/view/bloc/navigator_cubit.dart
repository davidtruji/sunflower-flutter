import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunflower_flutter/view/widget/navigator_state.dart';

class NavigatorCubit extends Cubit<NavigatorState> {
  NavigatorCubit() : super(ToTab());

  void toTabScreen() => emit(ToTab());

  void toPlantDetail() => emit(ToPlantDetail());

  void toPlantGallery() => emit(ToPlantGallery());
}
