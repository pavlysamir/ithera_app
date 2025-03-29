import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class CustomButtonLargeDimmed extends StatelessWidget {
  const CustomButtonLargeDimmed({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.blueLight,
        border: Border.all(color: AppColors.blueLight),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
          child: Text(text,
              style: AppTextStyles.font14Regular
                  .copyWith(color: AppColors.white))),
    );
  }
}
