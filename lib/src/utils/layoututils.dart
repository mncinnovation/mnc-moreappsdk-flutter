import 'package:flutter/widgets.dart';

extension Utils on int {
  BorderRadiusGeometry getRoundSize() {
    switch (this) {
      case 0:
        return BorderRadius.zero;
      case 1:
        return BorderRadius.circular(4.0);
      case 2:
        return BorderRadius.circular(8.0);
      default:
        return BorderRadius.circular(8.0);
    }
  }
}
