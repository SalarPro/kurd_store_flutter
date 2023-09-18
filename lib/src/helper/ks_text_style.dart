import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KSTextStyle {
  static light(
    double size, {
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
  }) {
    return TextStyle(
      fontSize: size,
      color: color ?? Colors.white,
      fontWeight: fontWeight ?? FontWeight.normal,
      fontFamily: fontFamily ?? GoogleFonts.roboto().fontFamily,
    );
  }

  static bold(
    double size, {
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
  }) {
    return TextStyle(
      fontSize: size,
      color: color ?? Colors.black,
      fontWeight: fontWeight ?? FontWeight.bold,
      fontFamily: fontFamily ?? GoogleFonts.roboto().fontFamily,
    );
  }
}
