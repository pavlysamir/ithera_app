import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class AddBalanceScreen extends StatelessWidget {
  const AddBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: Column(
          spacing: 24.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'أختار الطريقة المناسبة اليك',
              style:
                  AppTextStyles.font22Regular.copyWith(color: AppColors.black),
            ),
            Container(
              height: 60.h,
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: AppColors.blueMoreLight,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Row(
                children: [
                  Image.asset(
                    AssetsData.orangeWallet,
                    height: 40.h,
                    width: 40.w,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '8-90121234-567-3456',
                    style: AppTextStyles.font16Regular
                        .copyWith(color: AppColors.black),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                          const ClipboardData(text: '8-90121234-567-3456'));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Copied')),
                      );
                    },
                    child: Icon(Icons.copy,
                        color: AppColors.primaryColor, size: 25.h),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
