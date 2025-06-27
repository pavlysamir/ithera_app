import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_small.dart';

class CustomMultiSelectDropDown extends StatelessWidget {
  final List<String> items;
  final List<String> selectedItems;
  final Function(List<String>) onSelectionChanged;
  final bool isLoading;

  const CustomMultiSelectDropDown({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: isLoading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 1.5))
          : InkWell(
              onTap: () async {
                final result = await showDialog<List<String>>(
                  context: context,
                  builder: (context) {
                    return _MultiSelectDialog(
                      items: items,
                      selectedItems: selectedItems,
                    );
                  },
                );

                if (result != null) {
                  onSelectionChanged(result);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                alignment: Alignment.centerRight,
                child: selectedItems.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('اختار من القائمة',
                              style: AppTextStyles.font10Regular),
                          const RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              size: 16,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              selectedItems.join(', '),
                              style: AppTextStyles.font10Regular.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          const RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
    );
  }
}

class _MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;

  const _MultiSelectDialog({
    required this.items,
    required this.selectedItems,
  });

  @override
  State<_MultiSelectDialog> createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<_MultiSelectDialog> {
  late List<String> tempSelected;

  @override
  void initState() {
    super.initState();
    tempSelected = List.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      shadowColor: AppColors.grey300,
      content: SizedBox(
        height: 250.h,
        child: Scrollbar(
          controller: scrollController, // ✅ نفس الكنترولر هنا
          thumbVisibility: true,
          trackVisibility: true,
          radius: const Radius.circular(5),
          thickness: 5,
          scrollbarOrientation: ScrollbarOrientation.left,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: widget.items.map((item) {
                final isChecked = tempSelected.contains(item);
                return CheckboxListTile(
                  value: isChecked,
                  title: Text(item),
                  activeColor: AppColors.primaryColor,
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
                        if (tempSelected.length < 2) {
                          tempSelected.add(item);
                        } else {
                          // ممكن تضيف SnackBar أو Alert هنا
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('مسموح باختيار عنصرين فقط'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      } else {
                        tempSelected.remove(item);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('إلغاء'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        SizedBox(
          height: 45.h,
          child: CustomButtonSmall(
              function: () => Navigator.of(context).pop(tempSelected),
              text: 'تم',
              color: AppColors.primaryColor,
              borderColor: AppColors.primaryColor),
        ),
      ],
    );
  }
}
