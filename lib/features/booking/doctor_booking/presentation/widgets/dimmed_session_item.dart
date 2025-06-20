import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/widgets/custom_circle_line.dart';
import 'package:ithera_app/features/booking/patient_booking/data/models/patient_booking_model.dart';

class DimmedSessionListItem extends StatelessWidget {
  const DimmedSessionListItem({super.key, required this.session});

  final PatientSessionModel session;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCircleLine(status: session.status),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' من ${session.startTime} الي ${session.endTime}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppTextStyles.font14Regular.copyWith(
                  color: session.status == 0
                      ? AppColors.blackLight
                      : AppColors.black,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                '${session.startDate.day + 1}-${session.startDate.month}-${session.startDate.year}',
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.blackLight,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
      ],
    );
  }
}
