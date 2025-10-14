 
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '/core/presentation/widgets/global_text.dart';
import '../../theme/app_colors.dart';

class GlobalDropdown<T> extends StatelessWidget {
  const GlobalDropdown({
    super.key,
    required this.validator,
    required this.hintText,
    required this.onChanged,
    required this.items,
    this.borderRadius = 10,
    this.value,
  });

  final String? Function(T?)? validator;
  final String? hintText;
  final void Function(T?)? onChanged;
  final List<DropdownMenuItem<T>>? items;
  final double? borderRadius;
  final T? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final textColor = isDark ? AppColors.white.color : AppColors.black.color;
    final hintColor = isDark ? AppColors.lightGrey.color : AppColors.grey.color;

    return Theme(
      data: ThemeData(
        buttonTheme: ButtonTheme.of(context).copyWith(alignedDropdown: true),
      ),
      child: DropdownButtonFormField<T>(
        validator: validator,
        padding: EdgeInsets.zero,
        alignment: AlignmentDirectional.centerStart,
        icon: Icon(Icons.arrow_drop_down, color: AppColors.black.color),
        iconSize: 24.sp,
        value: value,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
          filled: true,
          fillColor: isDark ? AppColors.lightGrey.color : AppColors.white.color,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!.r),
            borderSide: BorderSide(color: AppColors.primary.color, width: 1.w),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error.color, width: 1.w),
            borderRadius: BorderRadius.circular(borderRadius!.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error.color, width: 1.w),
            borderRadius: BorderRadius.circular(borderRadius!.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!.r),
            borderSide: BorderSide(color: AppColors.grey.color, width: 1.w),
          ),
        ),
        isExpanded: true,
        // Improved hint with explicit color
        hint: GlobalText(
          str: hintText ?? '',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: hintColor,
        ),
        onChanged: onChanged,
        items:
            items?.map((item) {
              // Ensure each dropdown item has the correct text color
              if (item.child is Text) {
                final text = item.child as Text;
                return DropdownMenuItem<T>(
                  value: item.value,
                  child: Text(
                    text.data ?? '',
                    style: TextStyle(color: textColor, fontSize: 14.sp),
                  ),
                );
              } else if (item.child is GlobalText) {
                final globalText = item.child as GlobalText;
                return DropdownMenuItem<T>(
                  value: item.value,
                  child: GlobalText(
                    str: globalText.str,
                    fontSize: 14.sp,
                    color: textColor,
                  ),
                );
              }
              return item;
            }).toList() ??
            [],
        dropdownColor:
            isDark ? AppColors.greylish.color : AppColors.white.color,
        style: GoogleFonts.inter(
          color: textColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),

        itemHeight: 48.h,
        menuMaxHeight: 300.h,
        isDense: false,
      ),
    );
  }
}
