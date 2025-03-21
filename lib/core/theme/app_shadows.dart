import 'package:flutter/material.dart';
import 'package:ithera_app/core/theme/app_colors.dart';

class AppShadows {
  const AppShadows._();

  static BoxShadow shadow1 = BoxShadow(
    offset: const Offset(0, 1),
    blurRadius: 2,
    spreadRadius: 0,
    color: AppColors.shadow1Color,
  );
}
