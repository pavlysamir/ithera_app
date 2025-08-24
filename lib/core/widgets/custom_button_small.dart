import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class CustomButtonSmall extends StatelessWidget {
  const CustomButtonSmall(
      {super.key,
      required this.function,
      required this.text,
      required this.color,
      this.textColortcolor = Colors.white,
      this.width = 78,
      required this.borderColor});
  final Function() function;
  final String text;
  final Color color;
  final Color textColortcolor;
  final double width;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: function,
        child: Container(
          height: 40.h,
          width: width.w,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1.5),
            color: color,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Center(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTextStyles.font14Regular.copyWith(color: textColortcolor),
            ),
          ),
        ));
  }
}
