import 'package:flutter/material.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class CustomCheckboxRow extends StatelessWidget {
  const CustomCheckboxRow({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });
  final bool isChecked;
  final Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChanged,

          activeColor:
              AppColors.primaryColor, // لون الـ checkbox لما يكون متعلم
          checkColor: Colors.white, // لون علامة الصح
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Text(
          'بتحجز الجلسة لشخص اخر بعنوان مختلف',
          style: AppTextStyles.font14Regular.copyWith(
            color: AppColors.blackLight,
          ),
        ),
      ],
    );
  }
}
