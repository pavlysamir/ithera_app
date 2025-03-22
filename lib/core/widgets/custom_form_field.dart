import 'package:flutter/material.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField(
      {super.key,
      required this.controller,
      this.validationMassage,
      this.onChanged,
      required this.hintText,
      required this.textInputType,
      this.suffixIcon,
      this.prefixIcon,
      this.isEyeTrue = false,
      this.initialValue,
      this.readOnly = false});
  final TextEditingController controller;
  //final String validationMassage;
  final String hintText;
  final TextInputType textInputType;
  IconButton? suffixIcon;
  Icon? prefixIcon;
  Function(String value)? validationMassage;
  Function(String value)? onChanged;

  final bool isEyeTrue;
  final String? initialValue;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      readOnly: readOnly!,
      initialValue: initialValue,
      style: AppTextStyles.font14Regular,
      obscureText: isEyeTrue,
      keyboardType: textInputType,
      controller: controller,
      validator: (value) {
        return validationMassage!(value!);
      },
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      // focusNode: FocusNode(),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        //filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        //fillColor: Colors.grey[200],
        enabledBorder: outlineInputBorder(context),
        focusedBorder: outlineInputBorder(context),
        errorBorder: outlineInputBorderError(),
        hintText: hintText,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        hintStyle: AppTextStyles.font14Regular,
      ),
    );
  }
}

InputBorder? outlineInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.grey400),
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
