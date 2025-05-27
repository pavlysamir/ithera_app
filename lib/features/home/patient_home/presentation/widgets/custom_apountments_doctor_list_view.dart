import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/routing/navigation_services.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_shadows.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/features/home/patient_home/data/models/doctors_model.dart';

class CustomApountmentsDoctorListView extends StatelessWidget {
  const CustomApountmentsDoctorListView(
      {super.key, required this.regionSchedule});
  final List<DoctorRegionSchedule> regionSchedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      height: 230.h,
      child: ListView.builder(
        clipBehavior: Clip.none,

        //   physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: regionSchedule.length,

        itemBuilder: (context, index) {
          final schedule = regionSchedule[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              clipBehavior: Clip.none,
              width: 200.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [AppShadows.shadow1],
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    schedule.days.join(", "),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font16Regular,
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
                          schedule.regionName,
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
                          'من ${schedule.schedules[0].startTime} إلي ${schedule.schedules[0].endTime}',
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
                          'بداية من ${schedule.schedules[0].startDate.day}/${schedule.schedules[0].startDate.month}/${schedule.schedules[0].startDate.year}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font14Regular
                              .copyWith(color: AppColors.blackLight),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 38.h,
                    child: CustomButtonLarge(
                      text: 'احجز الأن',
                      color: AppColors.primaryColor,
                      function: () {
                        NavigationService().navigateTo(Routes.bookNowScreen);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
