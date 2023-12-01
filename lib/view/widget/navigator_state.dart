import 'package:flutter/widgets.dart';

@immutable
sealed class NavigatorState {}

final class ToTab extends NavigatorState {}

final class ToPlantDetail extends NavigatorState {}

final class ToPlantGallery extends NavigatorState {}
