import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class SmallBalanceContainer extends StatelessWidget {
  const SmallBalanceContainer(
      {super.key,
      required this.balance,
      required this.iconData,
      required this.title,
      required this.colorIcon});
  final String balance;
  final IconData iconData;
  final String title;
  final Color colorIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      // width: context.widthMediaQuery * 0.35,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: AppColors.blueLight,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5.r),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.font12Regular,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Icon(
                  iconData,
                  color: colorIcon,
                  size: 30.sp,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: Text(balance,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font25Bold
                      .copyWith(color: AppColors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
