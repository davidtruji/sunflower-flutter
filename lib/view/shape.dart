import 'package:flutter/material.dart';

final class Shape {
  static RoundedRectangleBorder sunflowerShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(12), bottomLeft: Radius.circular(12)));

  static MaterialStateProperty<RoundedRectangleBorder> filledButtonShape =
      MaterialStateProperty.all<RoundedRectangleBorder>(sunflowerShape);
}
