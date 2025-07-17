import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class CustomWalletFieldData extends StatelessWidget {
  const CustomWalletFieldData({
    super.key,
    required this.walletNumber,
    required this.walletImg,
  });
  final String walletNumber;
  final String walletImg;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.blueMoreLight,
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          color: AppColors.blueLight,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            walletImg,
            height: 40.h,
            width: 40.w,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              walletNumber,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTextStyles.font16Regular.copyWith(color: AppColors.black),
            ),
          ),
          // const Spacer(),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: walletNumber));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Copied')),
              );
            },
            child: Icon(Icons.copy, color: AppColors.primaryColor, size: 25.h),
          ),
        ],
      ),
    );
  }
}
