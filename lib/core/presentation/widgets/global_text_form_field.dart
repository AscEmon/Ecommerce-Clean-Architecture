import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';
import '/core/presentation/widgets/global_text.dart';

class GlobalTextFormField extends StatelessWidget {
  final bool? obscureText;
  final TextInputType? textInputType;
  final TextInputType? keyboardType; // Added for compatibility
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxlength;
  final AutovalidateMode? autovalidateMode;
  final bool? readOnly;
  final Color? fillColor;
  final String? hintText;
  final String? labelText;
  final String? errorText; // Added for real-time validation
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final bool? mandatoryLabel;
  final TextStyle? style;
  final int? line;
  final String? initialValue;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final double borderRadius;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  const GlobalTextFormField({
    super.key,
    this.obscureText,
    this.textInputType,
    this.keyboardType, // Added
    this.controller,
    this.validator,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.maxlength,
    this.initialValue,
    this.autovalidateMode,
    this.readOnly,
    this.hintText,
    this.labelText,
    this.errorText, // Added
    this.hintStyle,
    this.mandatoryLabel,
    this.labelStyle,
    this.line = 1,
    this.style,
    this.onChanged,
    this.textInputAction = TextInputAction.done,
    this.borderRadius = 10,
    this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    // Get theme colors
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Define colors based on theme
    final textColor = isDark ? AppColors.white.color : AppColors.black.color;
    final cursorColor =
        isDark ? AppColors.primary.color : AppColors.black.color;
    final fieldFillColor =
        isDark
            ? AppColors.greylish.color.withValues(alpha: 0.5)
            : fillColor ?? const Color.fromARGB(255, 250, 246, 246);
    final borderColor =
        isDark
            ? AppColors.grey.color
            : AppColors.grey.color.withValues(alpha: 0.2);
    final errorColor = AppColors.error.color;
    final primaryColor = AppColors.primary.color;

    return TextFormField(
      initialValue: initialValue,
      maxLines: line,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      style:
          style ??
          TextStyle(
            color: textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
      autovalidateMode: autovalidateMode,
      obscureText: obscureText ?? false,
      obscuringCharacter: '*',
      controller: controller,
      textInputAction: textInputAction,
      cursorColor: cursorColor,

      keyboardType: keyboardType ?? textInputType ?? TextInputType.text,
      onChanged: onChanged,
      maxLength: maxlength,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 14.w),
        prefixIcon: prefixIcon,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorText: errorText, // Show error from provider
        label:
            mandatoryLabel == true
                ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GlobalText(
                      str: labelText ?? '',
                      color: isDark ? AppColors.lightGrey.color : null,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    GlobalText(str: '*', color: errorColor, fontSize: 14),
                  ],
                )
                : GlobalText(
                  str: labelText ?? '',
                  color: isDark ? AppColors.lightGrey.color : null,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
        labelStyle:
            labelStyle ??
            TextStyle(
              color: isDark ? AppColors.lightGrey.color : AppColors.grey.color,
              fontSize: 14.sp,
            ),
        filled: true,
        counterText: '',

        fillColor: fieldFillColor,
        suffixIcon: suffixIcon,
        hintStyle:
            hintStyle ??
            TextStyle(
              color: isDark ? AppColors.lightGrey.color : AppColors.grey.color,
              fontSize: 14.sp,
            ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius.r)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(color: primaryColor, width: 1.w),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor, width: 1.w),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius.r)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor, width: 1.w),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius.r)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(color: borderColor, width: 1.w),
        ),
      ),
      validator: validator,
      readOnly: readOnly ?? false,
    );
  }
}
 