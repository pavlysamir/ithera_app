import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_shadows.dart';

import 'home_layout_cubit.dart';

class PatientHomeLayout extends StatefulWidget {
  const PatientHomeLayout({super.key});

  @override
  State<PatientHomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<PatientHomeLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeLayoutCubit(),
      child: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
        builder: (context, state) {
          var cubit = HomeLayoutCubit.get(context);
          return Scaffold(
            bottomNavigationBar: Stack(
              children: [
                Container(
                  height: 88.h,
                  decoration: BoxDecoration(boxShadow: [AppShadows.shadow1]),
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            'assets/icons/setting_icon.svg',
                            color: cubit.currentIndex == 0
                                ? AppColors.primaryColor
                                : Colors.black,
                            width: 13.w,
                            height: 24.h,
                          ),
                          label: 'الإعدادت'),
                      BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            'assets/icons/home_icon.svg',
                            color: cubit.currentIndex == 1
                                ? AppColors.primaryColor
                                : Colors.black,
                            height: 24.h,
                            width: 13.w,
                          ),
                          label: 'الصفحة الرئيسية'),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/icons/booking_icon.svg',
                          color: cubit.currentIndex == 2
                              ? AppColors.primaryColor
                              : Colors.black,
                          width: 13.w,
                          height: 24.h,
                        ),
                        label: 'الحجوزات',
                      ),
                    ],
                    currentIndex: cubit.currentIndex,
                    onTap: (index) {
                      cubit.changeBottomNavBar(index);
                    },
                  ),
                ),
                Positioned(
                  bottom: 0, // Adjust the position to be under the label
                  right: (MediaQuery.of(context).size.width / 3) *
                          cubit.currentIndex +
                      3.w, // Adjust the position to be under the icon
                  child: Container(
                    width: MediaQuery.of(context).size.width /
                        3, // Width of the underline
                    height: 6, // Thickness of the line
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor, // Blue color
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: CacheHelper.getBool(key: CacheConstants.isFromPatient) == true
                ? cubit.patientScreens[cubit.currentIndex]
                : cubit.doctorScreens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
