import 'package:flutter/material.dart';

extension TextStyleHelpers on TextStyle {
  blueBold({double fontSize = 20, FontWeight fontWeight = FontWeight.w700}) =>
      copyWith(
        fontSize: fontSize,
        color: const Color(0xFF1360D2),
        fontWeight: fontWeight,
      );
  blackBold({double fontSize = 20, FontWeight fontWeight = FontWeight.w700}) =>
      copyWith(
        fontSize: fontSize,
        color: const Color(0xFF000000),
        fontWeight: fontWeight,
      );
  thinText({double fontSize = 20, Color color = Colors.black}) => copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        height: 0,
      );
  semeiBold(
          {double fontSize = 17,
          Color color = const Color(0xFF656B81),
          FontWeight fontWeight = FontWeight.w500}) =>
      copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      );
  colorWeight(
          {Color color = const Color(0xFF0E1B3D),
          FontWeight fontWeight = FontWeight.w500}) =>
      copyWith(
        color: color,
        fontWeight: fontWeight,
      );
}
