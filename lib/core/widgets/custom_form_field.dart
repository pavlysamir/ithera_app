import 'package:flutter/material.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField(
      {super.key,
      required this.controller,
      this.onChanged,
      required this.hintText,
      required this.textInputType,
      this.suffixIcon,
      this.prefixIcon,
      this.showEyeIcon = false,
      this.initialValue,
      this.readOnly = false,
      this.validate});
  final TextEditingController controller;
  //final String validationMassage;
  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validate;
  final void Function(String value)? onChanged;

  final bool showEyeIcon;

  final String? initialValue;
  final bool? readOnly;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool get showEyeIcon => widget.showEyeIcon;
  bool? _showPasswordInState;
  @override
  void initState() {
    super.initState();
    if (showEyeIcon) {
      _showPasswordInState = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      readOnly: widget.readOnly!,
      initialValue: widget.initialValue,
      style: AppTextStyles.font14Regular.copyWith(
        color: AppColors.grey800,
      ),
      obscureText: _showPasswordInState ?? false,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      validator: widget.validate,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      // focusNode: FocusNode(),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        //filled: true,
        suffixIcon: showEyeIcon ? buildEyeShowIcon() : null,
        prefixIcon: widget.prefixIcon,
        //fillColor: Colors.grey[200],
        enabledBorder: outlineInputBorder(context),
        focusedBorder: outlineInputBorder(context),
        errorBorder: outlineInputBorderError(),
        hintText: widget.hintText,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        hintStyle: AppTextStyles.font14Regular,
      ),
    );
  }

  void handleHidePassword() {
    if (widget.showEyeIcon) {
      setState(() {
        _showPasswordInState = !_showPasswordInState!;
      });
    }
  }

  Widget buildEyeShowIcon() {
    return GestureDetector(
      onTap: handleHidePassword,
      child: Container(
        color: Colors.transparent,
        child: Icon(
          _showPasswordInState ?? false
              ? Icons.visibility_off
              : Icons.visibility,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget buildEyeHideIcon() {
    return GestureDetector(
      onTap: handleHidePassword,
      child: Container(
        color: Colors.transparent,
        child: const Icon(
          Icons.visibility,
          color: Colors.grey,
        ),
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
