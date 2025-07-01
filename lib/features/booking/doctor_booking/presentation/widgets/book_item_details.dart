import 'package:flutter/material.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/core/theme/app_shadows.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/features/booking/doctor_booking/data/models/doctor_booking_model.dart';

class DoctorBookItemDetails extends StatelessWidget {
  const DoctorBookItemDetails({super.key, required this.booking});
  final DoctorBookingModel booking;

  @override
  Widget build(BuildContext context) {
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
            Text(' أ / ${booking.patientName} ',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font16Regular.copyWith(
                  color: AppColors.primaryColor,
                )),
            Text(
              booking.arabicDaysLine,
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
                    booking.address,
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
                    'من ${booking.sessions.first.startTime} إلي ${booking.sessions.first.endTime} مساءً',
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
                    booking.mobileNumber,
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
      ),
    );
  }
}
