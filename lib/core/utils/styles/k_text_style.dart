import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '/core/theme/app_colors.dart';

class KTextStyle {
  static TextStyle customTextStyle({
    double fontSize = 12,
    fontWeight = FontWeight.normal,
    Color? color,
  }) {
    return GoogleFonts.poppins(
      color: color ?? AppColors.lightGrey.color,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    );
  }
}

