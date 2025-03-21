import 'package:flutter/material.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_fonts.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

ThemeData getLightTheme() {
  return ThemeData(
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    scaffoldBackgroundColor: AppColors.grey0,
    brightness: Brightness.light,
    fontFamily: AppFonts.alexandria,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      // Headline styles
      headlineLarge: AppTextStyles.font25Bold.copyWith(color: AppColors.white),
      headlineMedium:
          AppTextStyles.font14Regular.copyWith(color: AppColors.white),
      headlineSmall:
          AppTextStyles.font14Regular.copyWith(color: AppColors.white),

      // // Title styles
      // titleLarge: AppTextStyles.font20Bold.copyWith(color: AppColors.white),
      // titleMedium: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
      // titleSmall: AppTextStyles.font14Bold.copyWith(color: AppColors.white),

      // // Body styles
      // bodyLarge: AppTextStyles.font16Regular.copyWith(color: AppColors.white),
      // bodyMedium: AppTextStyles.font14Regular.copyWith(color: AppColors.white),
      // bodySmall: AppTextStyles.font12Regular.copyWith(color: AppColors.white),

      // // Display styles
      // displayLarge: AppTextStyles.font32Bold.copyWith(color: AppColors.white),
      // displayMedium: AppTextStyles.font28Regular.copyWith(color: AppColors.white),
      // displaySmall: AppTextStyles.font24Regular.copyWith(color: AppColors.white),

      // // Label styles
      // labelLarge: AppTextStyles.font14Medium.copyWith(color: AppColors.white),
      // labelMedium: AppTextStyles.font12Medium.copyWith(color: AppColors.white),
      // labelSmall: AppTextStyles.font10Medium.copyWith(color: AppColors.white),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: AppTextStyles.font20Regular.copyWith(
          color: AppColors.primaryColor,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primaryColor,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.grey0,
        disabledBackgroundColor: AppColors.grey100,
        disabledForegroundColor: AppColors.grey0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: AppTextStyles.font14Regular,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.grey200,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.grey50,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
        ),
      ),
      fillColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return AppColors.primaryColor;
        }
        return AppColors.grey0;
      }),
      filled: true,
      hintStyle: AppTextStyles.font14Regular.copyWith(color: AppColors.grey400),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey,
      selectedItemColor: AppColors.primaryColor,
      elevation: 0.0,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
