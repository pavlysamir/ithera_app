import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class CustomButtonLarge extends StatelessWidget {
  const CustomButtonLarge({
    super.key,
    required this.text,
    required this.color,
    this.textColor = Colors.white,
    required this.function,
    this.icon,
  });
  final String text;
  final Color color;
  final Color textColor;
  final Function() function;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 50.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: color),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
            child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.labelLarge,
            children: [
              TextSpan(
                  text: text,
                  style: AppTextStyles.font14Regular.copyWith(color: textColor)
                  // const TextStyle(
                  //   fontFamily: ,
                  //   overflow: TextOverflow.ellipsis)

                  ),
              WidgetSpan(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: icon,
              )),
            ],
          ),
        )),
      ),
    );
  }
}
