import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';

class CustomCircleLine extends StatelessWidget {
  const CustomCircleLine({super.key, this.isDimmed = false});
  final bool isDimmed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 15.sp,
          height: 15.sp,
          decoration: BoxDecoration(
            color: isDimmed ? AppColors.blueLight : AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 2.w,
          height: 80.h,
          color: isDimmed ? AppColors.blueLight : AppColors.primaryColor,
        ),
      ],
    );
  }
}
