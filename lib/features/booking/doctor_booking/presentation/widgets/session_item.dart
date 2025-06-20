import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_small.dart';
import 'package:ithera_app/core/widgets/pop_up_dialog.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/widgets/custom_circle_line.dart';
import 'package:ithera_app/features/booking/patient_booking/data/models/patient_booking_model.dart';

class SessionListItem extends StatelessWidget {
  const SessionListItem({super.key, required this.session});

  final PatientSessionModel session;

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PopUpDialog(
        function2: () {},
        function: () {
          Navigator.pop(context);
        },
        title: 'هل تريد بالتأكيد الغاء هذه الجلسة؟',
        img: AssetsData.deleteAccount,
        subTitle: '',
        colorButton1: AppColors.primaryColor,
        colorButton2: AppColors.white,
        textColortcolor1: Colors.white,
        textColortcolor2: AppColors.primaryColor,
        context: context,
      ),
    );
  }

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
                ' ${session.arabicDay} من ${session.startTime} الي ${session.endTime}',
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
                '${session.startDate.day}-${session.startDate.month}-${session.startDate.year}',
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.blackLight,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        _buildStatusOrButton(context),
      ],
    );
  }

  Widget _buildStatusOrButton(BuildContext context) {
    if (session.status == 0) return const SizedBox();

    if (session.status == 5) {
      return Text(
        'تم الالغاء',
        style: AppTextStyles.font14Regular.copyWith(color: AppColors.error100),
      );
    } else if (session.status == 4) {
      return Text(
        'تم اخذها',
        style: AppTextStyles.font14Regular.copyWith(color: AppColors.textGreen),
      );
    } else {
      return SizedBox(
        height: 45.h,
        child: CustomButtonSmall(
          width: 80.w,
          function: () => _showCancelDialog(context),
          text: 'تأجيل',
          color: AppColors.white,
          borderColor: AppColors.primaryColor,
          textColortcolor: AppColors.primaryColor,
        ),
      );
    }
  }
}
