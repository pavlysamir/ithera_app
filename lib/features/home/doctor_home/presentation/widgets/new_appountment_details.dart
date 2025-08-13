import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/features/home/doctor_home/data/models/doctor_schadules_model.dart';

class NewAppointmentDetails extends StatelessWidget {
  final RegionSchedule schadule;
  final Function() onTap;

  const NewAppointmentDetails({
    super.key,
    required this.schadule,
    required this.onTap,
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
              // Days display
              Text(
                schadule.days.join(', '),
                style: AppTextStyles.font16Regular,
              ),

              // Location row
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
                      schadule.regionName,
                      style: AppTextStyles.font14Regular
                          .copyWith(color: AppColors.blackLight),
                    ),
                  ),
                ],
              ),

              // Time range row
              Row(
                children: [
                  CustomSvgimage(
                    path: AssetsData.time_range,
                    hight: 16.sp,
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Text(
                      _getTimeRangeText(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font14Regular
                          .copyWith(color: AppColors.blackLight),
                    ),
                  ),
                ],
              ),

              // Delete button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 40.h,
                  child: CustomButtonLarge(
                    text: 'حذف',
                    color: AppColors.primaryColor,
                    function: onTap,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTimeRangeText() {
    if (schadule.schedules.isEmpty) {
      return 'غير محدد';
    }

    if (schadule.schedules.length == 1) {
      final schedule = schadule.schedules[0];
      return 'من ${schedule.startTime} إلي ${schedule.endTime}';
    }

    // If multiple schedules, show range from first to last
    final firstSchedule = schadule.schedules.first;
    final lastSchedule = schadule.schedules.last;
    return 'من ${firstSchedule.startTime} إلي ${lastSchedule.endTime}';
  }
}
