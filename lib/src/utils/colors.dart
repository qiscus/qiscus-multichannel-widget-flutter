import 'package:flutter/widgets.dart';

extension QColorExtension on String {
  Color toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse("0x$hexColor"));
  }
}
