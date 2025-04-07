import 'package:flutter/material.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class CustomTextRich extends StatelessWidget {
  const CustomTextRich({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onSecondTextTap,
    this.onSecondText = AppColors.textGreen,
  });

  final String firstText;
  final String secondText;
  final VoidCallback onSecondTextTap;
  final Color onSecondText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: AppTextStyles.font14Regular.copyWith(color: Colors.black),
        ),
        TextButton(
          onPressed: onSecondTextTap,
          child: Text(
            secondText,
            style: AppTextStyles.font14Regular.copyWith(
              decoration: TextDecoration.underline,
              color: onSecondText,
            ),
          ),
        )
      ],
    );
  }
}
