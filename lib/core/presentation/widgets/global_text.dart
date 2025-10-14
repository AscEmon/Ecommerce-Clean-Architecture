import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalText extends StatelessWidget {
  final String str;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool? softwrap;
  final double? height;
  final String? fontFamily;
  final TextStyle? style;

  const GlobalText({
    super.key,
    required this.str,
    this.fontWeight,
    this.fontSize,
    this.fontStyle,
    this.color,
    this.letterSpacing,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softwrap,
    this.height,
    this.fontFamily,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    // Get the current text color from theme
    final defaultTextColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Text(
      str,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softwrap,
      textScaler: TextScaler.linear(1.0),
      style:
          style ??
          GoogleFonts.inter(
            // Use provided color or default from theme
            color: color ?? defaultTextColor,
            fontSize: fontSize?.sp,
            fontWeight: fontWeight ?? FontWeight.w500,
            letterSpacing: letterSpacing,
            decoration: decoration,
            height: height,
            fontStyle: fontStyle,
          ),
    );
  }
}

