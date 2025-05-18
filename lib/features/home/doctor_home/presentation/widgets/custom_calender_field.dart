import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart' show AppColors;
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({super.key});

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('ar', ''), // لعرض التاريخ بالعربي
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String displayDate = selectedDate != null
        ? DateFormat('d MMMM yyyy', 'ar').format(selectedDate!)
        : 'اختر التاريخ';

    return InkWell(
        onTap: () => _selectDate(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: AppColors.primaryColor,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      displayDate,
                      style: selectedDate != null
                          ? AppTextStyles.font12Regular
                              .copyWith(color: AppColors.black)
                          : AppTextStyles.font12Regular,
                    ),
                  ),
                  const Expanded(
                    child: CustomSvgimage(
                      path: AssetsData.calender,
                    ),
                  )
                ],
              ),
            ),
          ),
        )

        // InputDecorator(
        //   decoration: const InputDecoration(
        //     labelText: 'تاريخ الجلسة',
        //     border: OutlineInputBorder(),
        //     suffixIcon: Icon(Icons.calendar_today),
        //   ),
        //   child: Text(displayDate),
        // ),
        );
  }
}
