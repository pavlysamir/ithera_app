import 'package:flutter/material.dart';
import 'package:ithera_app/core/theme/app_colors.dart';

class AppShadows {
  const AppShadows._();

  static BoxShadow shadow1 = BoxShadow(
    color: AppColors.grey100,
    spreadRadius: 1,
    blurRadius: 1,
    offset: const Offset(0, 1),
  );
}
