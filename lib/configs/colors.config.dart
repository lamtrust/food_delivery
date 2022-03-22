import 'package:flutter/material.dart';

class ColorConfigs extends MaterialColor {
  static const Color PRIMARY_COLOR = Color(0xFFE60000);

  ColorConfigs(int primary, Map<int, Color> swatch) : super(primary, swatch);
}
