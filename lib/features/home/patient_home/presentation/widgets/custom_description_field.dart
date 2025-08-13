import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class CustomDescriptionFormField extends StatelessWidget {
  const CustomDescriptionFormField(
      {super.key,
      required this.controller,
      this.validationMassage,
      required this.hintText,
      required this.textInputType});
  final TextEditingController controller;
  //final String validationMassage;
  final String hintText;
  final TextInputType textInputType;
  final Function(String value)? validationMassage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.h,
      child: TextFormField(
        maxLines: 10,
        keyboardType: textInputType,
        controller: controller,
        validator: (value) {
          return validationMassage!(value!);
        },
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          // filled: true,
          //fillColor: Colors.grey[200],
          enabledBorder: outlineInputBorder(context),
          focusedBorder: outlineInputBorder(context),
          hintText: hintText,
          hintStyle: AppTextStyles.font14Regular.copyWith(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

InputBorder? outlineInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.grey400),
    borderRadius: BorderRadius.circular(5.0),
  );
}

OutlineInputBorder outlineInputBorderError() {
  return OutlineInputBorder(
    borderSide:
        const BorderSide(color: Colors.red), // Border color changes to red
    borderRadius: BorderRadius.circular(14),
  );
}
