import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/widgets/custom_circle_line.dart';

class DimmedSessionListItem extends StatelessWidget {
  const DimmedSessionListItem({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.month,
    required this.year,
  });

  final String startTime, endTime;

  final int day;
  final int month;
  final int year;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomCircleLine(status: 0),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' من $startTime الي $endTime',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppTextStyles.font14Regular
                    .copyWith(color: AppColors.blackLight),
              ),
              SizedBox(height: 15.h),
              Text(
                '${day + 1}-$month-$year',
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
