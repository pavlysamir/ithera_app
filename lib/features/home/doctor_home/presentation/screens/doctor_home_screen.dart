import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/features/home/doctor_home/presentation/screens/add_appountment_screen.dart';
import 'package:ithera_app/features/home/doctor_home/presentation/widgets/accepted_account.dart';
import 'package:ithera_app/features/home/doctor_home/presentation/widgets/custom_title_appBar.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70.h,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  margin: EdgeInsets.only(top: 10.h),
                  height: 1,
                  color: AppColors.grey100,
                ),
              )),
          title: CustomTitleAppBar(),
          actionsPadding: EdgeInsets.symmetric(horizontal: 20.w),
          actions: [
            IconButton(
              icon: CustomSvgimage(
                hight: 30.h,
                color: AppColors.blackLight,
                path: 'assets/icons/notification_icon.svg',
              ),
              onPressed: () {},
            ),
          ]),
      body: AddAppountmentScreen(),

      //AcceptedAccount(),
    );
  }
}
