import 'package:cached_network_image/cached_network_image.dart';
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

class CustomActiveBookingContainer extends StatelessWidget {
  const CustomActiveBookingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [AppShadows.shadow1],
      ),
      width: double.infinity,
      //  height: 500,
      child: Column(spacing: 20, children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.blackLight)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                      placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                      imageUrl:
                          'https://thumbs.dreamstime.com/b/young-male-doctor-close-up-happy-looking-camera-56751540.jpg'),
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(' د/ أمجد هاني ',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font16Regular.copyWith(
                        color: AppColors.primaryColor,
                      )),
                  SizedBox(height: 4.h),
                  Text(
                    'اخصائى العلاج الطبيعى لحالات العظام والاطفال',
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.blackLight,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            CustomSvgimage(
              path: AssetsData.time_range,
              hight: 24.sp,
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: Text(
                'الجلسة القادمة : يوم الثلاثاء الساعة من 4 إلي 6 مساءً',
                maxLines: 3,
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
              hight: 24.sp,
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: Text(
                '01270347065',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font14Regular
                    .copyWith(color: AppColors.blackLight),
              ),
            ),
          ],
        ),
        CustomButtonLarge(
            text: 'مزيد من التفاصيل',
            color: AppColors.primaryColor,
            function: () {
              NavigationService().navigateTo(Routes.bookDetailsScreen);
            })
      ]),
    );
  }
}
