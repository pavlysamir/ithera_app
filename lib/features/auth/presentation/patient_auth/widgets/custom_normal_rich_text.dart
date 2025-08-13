import 'package:flutter/material.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class CustomNormalRichText extends StatelessWidget {
  const CustomNormalRichText({
    super.key,
    required this.firstText,
    required this.ischoosen,
  });
  final String firstText;
  final bool ischoosen;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: firstText, // الجزء الأول باللون الأسود
            style: AppTextStyles.font16Regular.copyWith(color: Colors.black),
          ),
          TextSpan(
            text: ischoosen
                ? '   (أختياري)'
                : '  *', // الجزء الثاني باللون الأحمر
            style: ischoosen
                ? const TextStyle(color: Colors.grey, fontSize: 11)
                : const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
