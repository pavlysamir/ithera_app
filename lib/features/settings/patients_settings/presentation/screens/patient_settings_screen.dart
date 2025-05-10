import 'package:flutter/material.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ithera_app/core/widgets/pop_up_dialog.dart';

class PatientSettingsScreen extends StatelessWidget {
  const PatientSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<SettingItemModel> settingItems = [
      SettingItemModel(
          title: 'تعديل الحساب',
          icon: Icons.person_2_outlined,
          onTap: () {
            Navigator.pushNamed(context, Routes.patientEditProfileScreen);
          }),
      SettingItemModel(
          title: 'اسعار الجلسات',
          icon: Icons.payments_outlined,
          onTap: () {
            Navigator.pushNamed(context, Routes.patientPricesScreen);
          }),
      SettingItemModel(
          title: 'تواصل معنا',
          icon: Icons.headphones,
          onTap: () {
            Navigator.pushNamed(context, Routes.patientContentUsScreen);
          }),
      SettingItemModel(
          title: 'حذف الحساب',
          icon: Icons.delete_forever_outlined,
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => PopUpDialog(
                      function2: () {},
                      function: () {
                        Navigator.pop(context);
                      },
                      title: 'هل انت متأكد من حذف الحساب',
                      img: AssetsData.deleteAccount,
                      subTitle: '',
                      colorButton1: AppColors.primaryColor,
                      colorButton2: AppColors.white,
                      textColortcolor1: Colors.white,
                      textColortcolor2: AppColors.primaryColor,
                      context: context,
                    ));
          }),
      SettingItemModel(
          title: 'تسجيل الخروج',
          icon: Icons.exit_to_app,
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => PopUpDialog(
                      function2: () {},
                      function: () {
                        Navigator.pop(context);
                      },
                      title: 'هل تريد بالتأكيد تسجيل الخروج من هذا الحساب؟',
                      img: AssetsData.logout,
                      subTitle: '',
                      colorButton1: AppColors.primaryColor,
                      colorButton2: AppColors.white,
                      textColortcolor1: Colors.white,
                      textColortcolor2: AppColors.primaryColor,
                      context: context,
                    ));
          }),
    ];
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return SlideInRight(
              animate: true,
              duration: const Duration(milliseconds: 300),
              from: 8,
              child: ListTile(
                title: Text(settingItems[index].title),
                leading: Icon(
                  settingItems[index].icon,
                  color: AppColors.primaryColor,
                ),
                onTap: settingItems[index].onTap,
              ),
            );
          },
          itemCount: settingItems.length,
        ),
      ),
    );
  }
}

class SettingItemModel {
  final String title;
  final IconData icon;
  final Function() onTap;

  SettingItemModel(
      {required this.title, required this.icon, required this.onTap});
}
