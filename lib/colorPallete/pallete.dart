import 'package:flutter/material.dart';
import 'dart:math';
// class Palette {
//   static const MaterialColor blue = const MaterialColor(
//     0x8080c5, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
//     const <int, Color>{
//       50: const Color(0x000046), //10%
//       100: const Color(0x000038), //20%
//       200: const Color(0x00002a), //30%
//       300: const Color(0x4d4dae), //40%
//       400: const Color(0x8080c5), //50%
//     },
//   );
// }
// Map<int, Color> color = {
//   50: Color(0x000046),
//   100: Color(0x000038),
//   200: Color(0x00002a),
//   300: Color(0x4d4dae),
//   400: Color(0x8080c5),
// };

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
