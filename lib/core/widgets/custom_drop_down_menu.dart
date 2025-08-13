import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_form_field.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.items,
    this.initialValue,
    required this.onChange,
    this.isLoading = false,
  });

  final List<dynamic> items;
  final String? initialValue;
  final Function(dynamic) onChange;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      width: double.infinity,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeWidth: 1.5,
              ),
            )
          : DropdownButtonFormField(
              padding: EdgeInsets.zero,
              icon: const RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 16,
                ),
              ),
              menuMaxHeight: 200,
              dropdownColor: Colors.white,
              decoration: InputDecoration(
                enabledBorder: outlineInputBorder(context),
                focusedBorder: outlineInputBorder(context),
                errorBorder: outlineInputBorderError(),
              ),
              hint: Text(initialValue ?? 'اختار من القائمة',
                  style: AppTextStyles.font12Regular),
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              value: initialValue,
              style: AppTextStyles.font10Regular.copyWith(
                color: AppColors.black,
              ),
              onChanged: (value) {
                if (value != null) {
                  onChange(value);
                }
              },
            ),
    );
  }
}
