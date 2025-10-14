import 'package:flutter/material.dart';

/// Application colors using enum
enum AppColors {
  scaffold(Color.fromARGB(255, 222, 242, 240)),
  // Primary colors
  primary(Color(0xFF26A69A)),
  primaryLight(Color(0xFF42A5F5)),
  primaryDark(Color(0xFF0D47A1)),

  // Secondary colors
  secondary(Color(0xFF26A69A)),
  secondaryLight(Color(0xFF4DB6AC)),
  secondaryDark(Color(0xFF00796B)),

  accent(Color(0xFF26A69A)),

  // Neutral colors
  black(Color(0xFF000000)),
  darkGrey(Color(0xFF4F4F4F)),
  grey(Color(0xFF9E9E9E)),
  lightGrey(Color(0xFFE0E0E0)),
  white(Color(0xFFFFFFFF)),

  greylish(Color(0xff303030)),
  transparent(Colors.transparent),
  yellow(Color(0xffF6D403)),
  // Status colors
  success(Color(0xFF4CAF50)),
  warning(Color(0xFFFFC107)),
  error(Color(0xFFF44336)),
  info(Color(0xFF2196F3)),
  red(Colors.red),
  green(Colors.green),
  orange(Colors.orange),

  // Background colors
  background(Color(0xFFF5F5F5)),
  cardBackground(Color.fromARGB(255, 216, 213, 213)),

  // Text colors
  textPrimary(Color(0xFF212121)),
  textSecondary(Color(0xFF757575)),
  textHint(Color(0xFFBDBDBD));

  final Color color;

  const AppColors(this.color);
}

