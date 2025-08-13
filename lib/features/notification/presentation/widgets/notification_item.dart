import 'package:flutter/material.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_shadows.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/features/notification/data/models/notifications_model.dart';

class NotificationWidgetItem extends StatelessWidget {
  const NotificationWidgetItem({super.key, required this.notificationItem});
  final NotificationItem notificationItem;
  @override
  Widget build(BuildContext context) {
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
          const CustomSvgimage(
            path: AssetsData.wallet,
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
