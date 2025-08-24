import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/routing/navigation_services.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_shadows.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_small.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/features/notification/data/enums/notification_types_enum.dart';
import 'package:ithera_app/features/notification/data/models/notifications_model.dart';

class NotificationWidgetItem extends StatelessWidget {
  const NotificationWidgetItem({super.key, required this.notificationItem});
  final NotificationItem notificationItem;
  @override
  Widget build(BuildContext context) {
    NotificationType type =
        NotificationTypeExtension.fromInt(notificationItem.type ?? 0);
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          AppShadows.shadow1,
        ],
      ),
      child: Row(
        children: [
          if (type == NotificationType.patientBookingRequestForDoctor)
            const CustomSvgimage(
              path: AssetsData.patientBookingRequestIcon,
              hight: 25,
            ),
          if (type == NotificationType.depositeRequestForAdmin ||
              type == NotificationType.depositeRequestForDoctor ||
              type == NotificationType.withDrawalRequest ||
              type == NotificationType.freezeMoney)
            const CustomSvgimage(
              path: AssetsData.cash,
              hight: 25,
            ),
          if (type == NotificationType.activeDoctorAccount ||
              type == NotificationType.activePatientAccount)
            const CustomSvgimage(
              path: AssetsData.confirmAccountIcon,
              hight: 25,
            ),
          if (type == NotificationType.inActiveDoctorAccount ||
              type == NotificationType.inActivePatientAccount)
            const CustomSvgimage(
              path: AssetsData.stopAccountIcon,
              hight: 25,
            ),
          if (type == NotificationType.bookingCancelation ||
              type == NotificationType.sessionCancelationForDoctor ||
              type == NotificationType.sessionCancelationForPatient)
            const CustomSvgimage(
              path: AssetsData.stopAccountIcon,
              hight: 25,
            ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notificationItem.value ?? '',
                  style: AppTextStyles.font16Regular,
                ),
                const SizedBox(
                  height: 5,
                ),
                if (type == NotificationType.patientBookingRequestForDoctor)
                  SizedBox(
                    height: 45.h,
                    child: CustomButtonSmall(
                      width: 90.w,
                      function: () {
                        NavigationService().navigateTo(
                            Routes.bookingNotificationDetailsScreen,
                            arguments: {
                              'bookingId': notificationItem.bookingId
                            });
                      },
                      text: 'تفاصيل اكتر',
                      color: AppColors.primaryColor,
                      borderColor: AppColors.primaryColor,
                      textColortcolor: AppColors.white,
                    ),
                  ),
                // Text(
                //   'You have a new notification',
                //   style: AppTextStyles.font12Regular,
                // ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  ' ${notificationItem.createdOn!.day}-${notificationItem.createdOn!.month}-${notificationItem.createdOn!.year}, الساعة: ${notificationItem.createdOn!.hour}:${notificationItem.createdOn!.minute}',
                  style: AppTextStyles.font10Regular,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
