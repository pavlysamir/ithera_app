import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

class NewApppountmentDetails extends StatelessWidget {
  const NewApppountmentDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'السبت - الأحد - الأتنين ',
                style: AppTextStyles.font16Regular,
              ),
              Row(
                children: [
                  CustomSvgimage(
                    path: 'assets/icons/location.svg',
                    hight: 16.sp,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Text(
                      '12ش صلاح سالم - مدينة نصر ',
                      style: AppTextStyles.font14Regular
                          .copyWith(color: AppColors.blackLight),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  CustomSvgimage(
                    path: AssetsData.time_range,
                    hight: 16.sp,
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Text(
                      'من 4 إلي 6 مساءً',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font14Regular
                          .copyWith(color: AppColors.blackLight),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 40.h,
                  child: CustomButtonLarge(
                      text: 'حذف',
                      color: AppColors.primaryColor,
                      function: () {}),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
