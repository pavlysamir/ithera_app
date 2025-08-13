import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_shadows.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/custom_normal_rich_text.dart';

class CustomToggleisMale extends StatelessWidget {
  CustomToggleisMale({
    super.key,
    required this.isMale,
    required this.onMaleTap,
    required this.onFemaleTap,
    this.fromAuth = true,
  });
  bool? isMale;
  final bool fromAuth;

  Function()? onMaleTap;
  Function()? onFemaleTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fromAuth
                  ? const CustomNormalRichText(
                      ischoosen: false,
                      firstText: 'النوع',
                    )
                  : Text(
                      'النوع',
                      style: AppTextStyles.font16Regular
                          .copyWith(color: Colors.black),
                    ),
              SizedBox(
                height: 18.h,
              ),
              InkWell(
                onTap: onMaleTap,
                child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: isMale == null
                            ? AppColors.white
                            : isMale == true
                                ? AppColors.primaryColor
                                : AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          AppShadows.shadow1,
                        ]),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'ذكر',
                            style: AppTextStyles.font20Regular.copyWith(
                                color: isMale == null
                                    ? AppColors.primaryColor
                                    : isMale == true
                                        ? AppColors.white
                                        : AppColors.primaryColor),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SvgPicture.asset(
                            AssetsData.male,
                            height: 36,
                            color: isMale == null
                                ? AppColors.primaryColor
                                : isMale == true
                                    ? AppColors.white
                                    : AppColors.primaryColor,
                          ),
                        ])),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(''),
              SizedBox(
                height: 18.h,
              ),
              InkWell(
                onTap: onFemaleTap,
                child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: isMale == null
                            ? AppColors.white
                            : isMale == false
                                ? AppColors.primaryColor
                                : AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          AppShadows.shadow1,
                        ]),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'أنثى',
                            style: AppTextStyles.font20Regular.copyWith(
                                color: isMale == null
                                    ? AppColors.primaryColor
                                    : isMale == false
                                        ? AppColors.white
                                        : AppColors.primaryColor),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SvgPicture.asset(
                            AssetsData.female,
                            height: 36,
                            color: isMale == null
                                ? AppColors.primaryColor
                                : isMale == false
                                    ? AppColors.white
                                    : AppColors.primaryColor,
                          ),
                        ])),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
