import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_fonts.dart';
import 'font_weight_helper.dart';

class AppTextStyles {
  const AppTextStyles._();
  // heading

  static TextStyle font28Medium = TextStyle(
    fontSize: 28.sp,
    fontFamily: AppFonts.alexandria,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.primaryColor,
  );

  static TextStyle font25Bold = TextStyle(
    fontSize: 25.sp,
    fontFamily: AppFonts.alexandria,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.primaryColor,
  );

  static TextStyle font25Medium = TextStyle(
    fontSize: 25.sp,
    fontFamily: AppFonts.alexandria,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.white,
  );

  static TextStyle font16Regular = TextStyle(
    fontSize: 16.sp,
    fontFamily: AppFonts.alexandria,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.black,
  );

  static TextStyle font14Regular = TextStyle(
    fontSize: 14.sp,
    fontFamily: AppFonts.alexandria,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.textGrey,
  );

  static TextStyle font12Regular = TextStyle(
    fontSize: 12.sp,
    fontFamily: AppFonts.alexandria,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.textGrey,
  );
  static TextStyle font10Regular = TextStyle(
    fontSize: 10.sp,
    fontFamily: AppFonts.alexandria,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.textGrey,
  );
  static TextStyle font20Regular = TextStyle(
    fontSize: 20.sp,
    fontFamily: AppFonts.alexandria,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.textGrey,
    height: 1.6,
  );

  static TextStyle font22Regular = TextStyle(
    fontSize: 22.sp,
    fontFamily: AppFonts.alexandria,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.white,
    height: 1.6,
  );
}
