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
import 'package:ithera_app/features/booking/patient_booking/data/models/patient_booking_model.dart';

class CustomActiveBookingContainer extends StatelessWidget {
  const CustomActiveBookingContainer({super.key, required this.activeBookings});
  final PatientBookingModel activeBookings;
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
                  Text(' د/ ${activeBookings.doctorName}',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font16Regular.copyWith(
                        color: AppColors.primaryColor,
                      )),
                  SizedBox(height: 4.h),
                  Text(
                    activeBookings.field,
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
                'الجلسة القادمة : يوم ${activeBookings.sessions.first.arabicDay} الساعة من ${activeBookings.sessions.first.startTime} إلي ${activeBookings.sessions.first.endTime} مساءً',
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
                activeBookings.mobileNumber,
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
