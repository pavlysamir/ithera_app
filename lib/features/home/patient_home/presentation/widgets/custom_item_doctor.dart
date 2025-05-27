import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/routing/navigation_services.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

import 'package:ithera_app/core/assets/assets.dart';

import 'package:ithera_app/core/theme/app_shadows.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_cubit.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_state.dart';
import 'package:ithera_app/features/home/patient_home/data/models/doctors_model.dart';
import 'package:ithera_app/features/home/patient_home/presentation/widgets/custom_star_rating.dart';

class CustomItemDoctor extends StatelessWidget {
  const CustomItemDoctor({
    super.key,
    required this.doctorModel,
  });
  final DoctorModel doctorModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BadeLookUpCubit, BadeLookUpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            //  height: context.hightMediaQuery * 0.5, // Adjust height dynamically
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [AppShadows.shadow1],
            ),
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        AssetsData.onBording_1,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(' د/ ${doctorModel.doctorName} ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.font16Regular.copyWith(
                              color: AppColors.primaryColor,
                            )),
                        SizedBox(height: 4.h),
                        Text(
                          doctorModel.specializationFields.first.nameAr,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font14Regular.copyWith(
                            color: AppColors.blackLight,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        StarRating(
                          rating: doctorModel.averageRating,
                          size: 15,
                          color: Colors.amber,
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            CustomSvgimage(
                              path: 'assets/icons/location.svg',
                              hight: 16.sp,
                            ),
                            SizedBox(width: 5.w),
                            Expanded(
                              child: Text(
                                BadeLookUpCubit.get(context)
                                        .getCityNameById(doctorModel.cityId) ??
                                    'مدينة غير معروفه',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.font14Regular
                                    .copyWith(color: AppColors.blackLight),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            CustomSvgimage(
                              path: 'assets/icons/cash.svg',
                              hight: 16.sp,
                            ),
                            SizedBox(width: 5.w),
                            Expanded(
                              child: Text(
                                'سعر الجلسة :  ${doctorModel.sessionPrice} جنيه',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.font14Regular
                                    .copyWith(color: AppColors.blackLight),
                              ),
                            ),
                          ],
                        ),
                        // Spacer(),
                        SizedBox(
                          height: 45.h,
                          child: CustomButtonLarge(
                            text: 'احجز الأن',
                            color: AppColors.primaryColor,
                            function: () {
                              if (doctorModel != null) {
                                NavigationService().navigateTo(
                                  Routes.doctorScreen,
                                  arguments: doctorModel,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
