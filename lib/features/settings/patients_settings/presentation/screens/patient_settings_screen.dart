import 'package:flutter/material.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

class PatientSettingsScreen extends StatelessWidget {
  const PatientSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<SettingItemModel> settingItems = [
      SettingItemModel(
          title: 'تعديل الحساب', icon: Icons.person_2_outlined, onTap: () {}),
      SettingItemModel(
          title: 'تواصل معنا', icon: Icons.headphones, onTap: () {}),
      SettingItemModel(
          title: 'حذف الحساب',
          icon: Icons.delete_forever_outlined,
          onTap: () {}),
      SettingItemModel(
          title: 'تسجيل الخروج', icon: Icons.exit_to_app, onTap: () {}),
    ];
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
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
