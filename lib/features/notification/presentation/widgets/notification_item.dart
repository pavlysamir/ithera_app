import 'package:flutter/material.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_shadows.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

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
                  'تم استلام حجز جديد من محمد علي.',
                  style: AppTextStyles.font16Regular,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'You have a new notification',
                  style: AppTextStyles.font12Regular,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  ' 4.2.2025 الساعة 12:30 مساءً',
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