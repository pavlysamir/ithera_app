import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';

class CustomImportImageField extends StatelessWidget {
  const CustomImportImageField(
      {super.key,
      this.onTap,
      this.color = AppColors.white,
      this.isDownload = false});
  final Function()? onTap;
  final Color? color;
  final bool isDownload;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: isDownload ? AppColors.primaryColor : color,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        child: isDownload
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('تحميل الملف', style: TextStyle(color: AppColors.white)),
                  Icon(Icons.download, size: 35, color: AppColors.white),
                ],
              )
            : const Icon(Icons.upload, size: 35, color: AppColors.grey500),
      ),
    );
  }
}
