import 'package:flutter/material.dart';

class CustomTextStyles {
  // Inter Regular text style
  static TextStyle interRegular({
    double fontSize = 16.0,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
    );
  }

  // Inter Black text style (heavier weight)
  static TextStyle interBlack({
    double fontSize = 16.0,
    Color color = Colors.black,
    FontWeight? fontWeight,  // Black weight
    TextDecoration decoration = TextDecoration.none,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: fontSize,
      fontWeight: fontWeight,  // Black weight
      color: color,
      decoration: decoration,
    );
  }

  // Manrope Regular text style
  static TextStyle manropeRegular({
    double fontSize = 16.0,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return TextStyle(
      fontFamily: 'Manrope',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
    );
  }

  // Title Style using Inter Black
  static TextStyle titleInter({
    double fontSize = 24.0,
    Color color = Colors.black,
  }) {
    return interBlack(fontSize: fontSize, color: color);
  }

  // Subtitle Style using Inter Regular
  static TextStyle subtitleInter({
    double fontSize = 18.0,
    Color color = Colors.grey,
    FontWeight? fontWeight,
  }) {
    return interBlack(fontSize: fontSize, color: color, fontWeight: fontWeight!);
  }
  // Subtitle Style using Manrope Regular
  static TextStyle subtitleManRope({
    double fontSize = 18.0,
    Color color = Colors.grey,
  }) {
    return manropeRegular(fontSize: fontSize, color: color);
  }

  // Body text using Inter Regular
  static TextStyle bodyInter({
    double fontSize = 16.0,
    Color color = Colors.black,
  }) {
    return interRegular(fontSize: fontSize, color: color);
  }
}
