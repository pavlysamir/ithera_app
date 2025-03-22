import 'package:flutter/material.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_form_field.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.items,
    this.initialValue,
    required this.onChange,
  });

  final List<dynamic> items;
  final String? initialValue;
  final Function(dynamic) onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50.h,
      width: double.infinity,
      child: DropdownButtonFormField(
          icon: RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: 16,
              )),
          menuMaxHeight: 200,
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            //  filled: true,
            // fillColor: Colors.grey[100],
            enabledBorder: outlineInputBorder(context),
            focusedBorder: outlineInputBorder(context),
            errorBorder: outlineInputBorderError(),
          ),
          hint: Text(
            initialValue ?? 'Select',
            style:
                AppTextStyles.font16Regular.copyWith(color: AppColors.grey400),
          ),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          value: initialValue,
          onChanged: (value) {
            if (value != null) {
              onChange(value);
            }
          }),
    );
  }
}
