import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/routing/navigation_services.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_shadows.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/features/booking/doctor_booking/data/models/doctor_booking_model.dart';
import 'package:ithera_app/features/booking/patient_booking/presentation/screens/no_booking_screen.dart';

class CustomBookingDoctorListView extends StatelessWidget {
  const CustomBookingDoctorListView({
    super.key,
    required this.bookings,
  });
  final List<DoctorBookingModel> bookings;

  @override
  Widget build(BuildContext context) {
    return bookings.isEmpty
        ? const NoBookingScreen()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20.h,
                  );
                },
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        AppShadows.shadow1,
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        spacing: 10.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(' أ / ${bookings[index].patientName} ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.font16Regular.copyWith(
                                color: AppColors.primaryColor,
                              )),
                          Text(
                            bookings[index].arabicDaysLine,
                            style: AppTextStyles.font16Regular,
                          ),
                          Row(
                            children: [
                              CustomSvgimage(
                                path: 'assets/icons/location.svg',
                                hight: 16.sp,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: Text(
                                  bookings[index].address,
                                  style: AppTextStyles.font14Regular
                                      .copyWith(color: AppColors.blackLight),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomSvgimage(
                                path: AssetsData.time_range,
                                hight: 16.sp,
                              ),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: Text(
                                  'من ${bookings[index].sessions.first.startTime} إلي ${bookings[index].sessions.first.endTime} مساءً',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.font14Regular
                                      .copyWith(color: AppColors.blackLight),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomSvgimage(
                                path: AssetsData.call,
                                hight: 16.sp,
                              ),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: Text(
                                  bookings[index].mobileNumber,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.font14Regular
                                      .copyWith(color: AppColors.blackLight),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40.h,
                            child: CustomButtonLarge(
                              text: 'مزيد من التفاصيل',
                              color: AppColors.primaryColor,
                              function: () {
                                NavigationService().navigateTo(
                                    Routes.bookDetailsScreen,
                                    arguments: bookings[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
  }
}
