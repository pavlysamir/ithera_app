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

class CustomBookingDoctorListView extends StatelessWidget {
  const CustomBookingDoctorListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 20.h,
            );
          },
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  AppShadows.shadow1,
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  spacing: 10.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(' أ / أمجد هاني ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.font16Regular.copyWith(
                          color: AppColors.primaryColor,
                        )),
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
                    Row(
                      children: [
                        CustomSvgimage(
                          path: AssetsData.call,
                          hight: 16.sp,
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Text(
                            '01270347065',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.font14Regular
                                .copyWith(color: AppColors.blackLight),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32.h,
                      child: CustomButtonLarge(
                        text: 'مزيد من التفاصيل',
                        color: AppColors.primaryColor,
                        function: () {
                          NavigationService()
                              .navigateTo(Routes.bookDetailsScreen);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
