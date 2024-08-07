import 'package:flutter/cupertino.dart';

class GlobalFunction {
  static Color darkenColor(Color color, [double amount = 0.15]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
