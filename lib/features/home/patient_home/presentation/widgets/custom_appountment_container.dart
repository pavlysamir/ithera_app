import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_shadows.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

class CustomAppountmentContainer extends StatelessWidget {
  const CustomAppountmentContainer(
      {super.key,
      required this.days,
      required this.city,
      required this.timeRange,
      required this.startDate});
  final String days;
  final String city;

  final String timeRange;
  final String startDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      width: double.infinity,
      //height: 180.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [AppShadows.shadow1],
      ),
      padding: const EdgeInsets.all(13),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            days,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font16Regular
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
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
                  city,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font14Regular
                      .copyWith(color: AppColors.blackLight),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              CustomSvgimage(
                path: AssetsData.time_range,
                hight: 16.sp,
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: Text(
                  timeRange,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font14Regular
                      .copyWith(color: AppColors.blackLight),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              CustomSvgimage(
                path: AssetsData.calender,
                hight: 16.sp,
                color: AppColors.primaryColor,
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: Text(
                  startDate,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font14Regular
                      .copyWith(color: AppColors.blackLight),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
