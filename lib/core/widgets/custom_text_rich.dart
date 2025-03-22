import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class CustomTextRich extends StatelessWidget {
  const CustomTextRich({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onSecondTextTap,
  });

  final String firstText;
  final String secondText;
  final VoidCallback onSecondTextTap;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: firstText,
              style: AppTextStyles.font14Regular.copyWith(color: Colors.black)),
          TextSpan(
            text: secondText,
            style: AppTextStyles.font14Regular.copyWith(
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onSecondTextTap,
          ),
        ],
      ),
    );
  }
}
