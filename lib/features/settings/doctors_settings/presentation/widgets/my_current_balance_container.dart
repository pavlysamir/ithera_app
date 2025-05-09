import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/theme/font_weight_helper.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

class MyCurrentBalanceContainer extends StatelessWidget {
  const MyCurrentBalanceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140.h,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.backgroundWelcome,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(5.r),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'رصيدك الحالي',
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text('500 جنيه',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppTextStyles.font25Medium.copyWith(
                          fontWeight: FontWeightHelper.bold,
                        )),
                  ],
                ),
              ),
              CustomSvgimage(
                path: AssetsData.wallet,
                hight: 122,
              ),
            ],
          ),
        ));
  }
}
