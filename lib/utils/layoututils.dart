import 'package:flutter/widgets.dart';

extension Utils on int {
  BorderRadiusGeometry getRoundSize() {
    switch (this) {
      case 0:
        return BorderRadius.zero;
        break;
      case 1:
        return BorderRadius.circular(4.0);
        break;
      case 2:
        return BorderRadius.circular(8.0);
        break;
      default:
        return BorderRadius.circular(8.0);
    }
  }
}
