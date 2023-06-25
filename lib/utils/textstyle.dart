import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyles({required double fontSize, FontWeight ?fontWeight, Color? color}){
  return GoogleFonts.dmSans(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color
  );
}
