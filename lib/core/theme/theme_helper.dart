import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      // Enhanced dropdown styling for light theme
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: TextStyle(color: AppColors.black.color),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.white.color),
          shadowColor: WidgetStatePropertyAll(
            AppColors.grey.color.withValues(alpha: 0.2),
          ),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8.h)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white.color,
          hintStyle: TextStyle(color: AppColors.grey.color),
          labelStyle: TextStyle(color: AppColors.black.color),
          errorStyle: TextStyle(color: AppColors.error.color),
          errorMaxLines: 3,
          iconColor: AppColors.black.color,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 12.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.grey.color),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.grey.color),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.primary.color),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.grey.color,
        refreshBackgroundColor: AppColors.primary.color,
      ),
      checkboxTheme: CheckboxThemeData(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        fillColor: WidgetStateProperty.resolveWith(
          (states) => AppColors.red.color,
        ),
        checkColor: WidgetStateProperty.resolveWith(
          (states) => AppColors.white.color,
        ),
        side: WidgetStateBorderSide.resolveWith(
          (states) => BorderSide(color: AppColors.red.color, width: 2.w),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r), // Rounded corners (4px)
        ),
      ),
      cardTheme: CardThemeData(color: AppColors.white.color),
      dialogTheme: DialogThemeData(backgroundColor: AppColors.white.color),
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.white.color),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.transparent.color,
        modalBackgroundColor: AppColors.white.color,
        modalElevation: 1,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.resolveWith(
            (states) => AppColors.black.color,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.greylish.color,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(color: AppColors.white.color),
      ),
      listTileTheme: ListTileThemeData(
        dense: true,
        horizontalTitleGap: 0,
        textColor: AppColors.white.color,
        contentPadding: EdgeInsets.zero,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white.color,
        selectedItemColor: AppColors.red.color,
        unselectedItemColor: AppColors.grey.color,
        type: BottomNavigationBarType.fixed,
      ),
      tabBarTheme: TabBarThemeData(
        tabAlignment: TabAlignment.start,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: AppColors.black.color,
        indicatorColor: AppColors.transparent.color,
        dividerColor: AppColors.transparent.color,
        unselectedLabelColor: AppColors.grey.color,
        overlayColor: WidgetStateColor.resolveWith(
          (states) => AppColors.transparent.color,
        ),
        labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(
          fontSize: 10.sp,
          color: AppColors.red.color,
          fontWeight: FontWeight.bold,
        ),
      ),
      radioTheme: RadioThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fillColor: WidgetStateProperty.resolveWith(
          (states) => AppColors.white.color,
        ),
      ),
      primaryColor: AppColors.white.color,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white.color,
        iconTheme: IconThemeData(color: AppColors.black.color),
        titleTextStyle: TextStyle(color: AppColors.black.color),
      ),
      scaffoldBackgroundColor: AppColors.white.color,
      textTheme: TextTheme(
        displayLarge: TextStyle(color: AppColors.black.color),
        displayMedium: TextStyle(color: AppColors.black.color),
        displaySmall: TextStyle(color: AppColors.black.color),
        headlineLarge: TextStyle(color: AppColors.black.color),
        headlineMedium: TextStyle(color: AppColors.black.color),
        headlineSmall: TextStyle(color: AppColors.black.color),
        titleLarge: TextStyle(color: AppColors.black.color),
        titleMedium: TextStyle(color: AppColors.black.color),
        titleSmall: TextStyle(color: AppColors.black.color),
        bodyLarge: TextStyle(color: AppColors.black.color),
        bodyMedium: TextStyle(color: AppColors.black.color),
        bodySmall: TextStyle(color: AppColors.black.color),
        labelLarge: TextStyle(color: AppColors.black.color),
        labelMedium: TextStyle(color: AppColors.black.color),
        labelSmall: TextStyle(color: AppColors.black.color),
      ),
      iconTheme: IconThemeData(color: AppColors.black.color),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      // Enhanced dropdown styling for dark theme
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: TextStyle(color: AppColors.white.color),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.greylish.color),
          shadowColor: WidgetStatePropertyAll(
            AppColors.black.color.withValues(alpha: 0.3),
          ),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8.h)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.greylish.color,
          hintStyle: TextStyle(color: AppColors.lightGrey.color),
          labelStyle: TextStyle(color: AppColors.white.color),
          errorStyle: TextStyle(color: AppColors.error.color),
          errorMaxLines: 3,
          iconColor: AppColors.white.color,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 12.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.grey.color),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.grey.color),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.primary.color),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.grey.color,
        refreshBackgroundColor: AppColors.primary.color,
      ),
      checkboxTheme: CheckboxThemeData(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        fillColor: WidgetStateProperty.resolveWith(
          (states) => AppColors.red.color,
        ),
        checkColor: WidgetStateProperty.resolveWith(
          (states) => AppColors.white.color,
        ),
        side: WidgetStateBorderSide.resolveWith(
          (states) => BorderSide(color: AppColors.red.color, width: 2.w),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r), // Rounded corners (4px)
        ),
      ),
      cardTheme: CardThemeData(color: AppColors.greylish.color),
      dialogTheme: DialogThemeData(backgroundColor: AppColors.greylish.color),
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.black.color),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.transparent.color,
        modalBackgroundColor: AppColors.greylish.color,
        modalElevation: 1,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.resolveWith(
            (states) => AppColors.white.color,
          ),
        ),
      ),
      primaryColor: AppColors.black.color,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.greylish.color,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(color: AppColors.black.color),
      ),
      listTileTheme: ListTileThemeData(
        dense: true,
        horizontalTitleGap: 0,
        textColor: AppColors.white.color,
        contentPadding: EdgeInsets.zero,
      ),
      radioTheme: RadioThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fillColor: WidgetStateProperty.resolveWith(
          (states) => AppColors.white.color,
        ),
      ),
      tabBarTheme: TabBarThemeData(
        indicatorSize: TabBarIndicatorSize.label,
        tabAlignment: TabAlignment.start,
        labelColor: AppColors.white.color,
        indicatorColor: AppColors.transparent.color,
        dividerColor: AppColors.transparent.color,
        unselectedLabelColor: AppColors.grey.color,
        overlayColor: WidgetStateColor.resolveWith(
          (states) => AppColors.transparent.color,
        ),
        labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(
          fontSize: 10.sp,
          color: AppColors.red.color,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.greylish.color,
        selectedItemColor: AppColors.red.color,
        unselectedItemColor: AppColors.grey.color,
        type: BottomNavigationBarType.fixed,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.black.color,
        iconTheme: IconThemeData(color: AppColors.white.color),
        titleTextStyle: TextStyle(color: AppColors.white.color),
      ),
      scaffoldBackgroundColor: AppColors.black.color,
      textTheme: TextTheme(
        displayLarge: TextStyle(color: AppColors.white.color),
        displayMedium: TextStyle(color: AppColors.white.color),
        displaySmall: TextStyle(color: AppColors.white.color),
        headlineLarge: TextStyle(color: AppColors.white.color),
        headlineMedium: TextStyle(color: AppColors.white.color),
        headlineSmall: TextStyle(color: AppColors.white.color),
        titleLarge: TextStyle(color: AppColors.white.color),
        titleMedium: TextStyle(color: AppColors.white.color),
        titleSmall: TextStyle(color: AppColors.white.color),
        bodyLarge: TextStyle(color: AppColors.white.color),
        bodyMedium: TextStyle(color: AppColors.white.color),
        bodySmall: TextStyle(color: AppColors.white.color),
        labelLarge: TextStyle(color: AppColors.white.color),
        labelSmall: TextStyle(color: AppColors.white.color),
        labelMedium: TextStyle(color: AppColors.white.color),
      ),
      iconTheme: IconThemeData(color: AppColors.white.color),
    );
  }
}

