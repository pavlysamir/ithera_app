import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';

class AddDateFormField extends StatelessWidget {
  const AddDateFormField(
      {super.key,
      required this.hintText,
      required this.items,
      required this.selectedItems,
      required this.onSelectionChanged,
      required this.isLoading,
      required this.isDates});
  final List<String> items;
  final List<String> selectedItems;
  final Function(List<String>) onSelectionChanged;
  final bool isLoading;
  final String hintText;
  final bool isDates;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await showDialog<List<String>>(
          context: context,
          builder: (context) {
            return isDates
                ? _MultiSelectDatesDialog(
                    items: items,
                    selectedItems: selectedItems,
                  )
                : _MultiSelectDialog(
                    items: items,
                    selectedItems: selectedItems,
                  );
          },
        );

        if (result != null) {
          onSelectionChanged(result);
        }
      },
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
          child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  hintText,
                  style: selectedItems.isNotEmpty
                      ? AppTextStyles.font12Regular
                          .copyWith(color: AppColors.black)
                      : AppTextStyles.font12Regular,
                ),
              )),
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
  late List<String> filteredItems;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tempSelected = List.from(widget.selectedItems);
    filteredItems = List.from(widget.items);
    searchController.addListener(() {
      final query = searchController.text.toLowerCase();
      setState(() {
        filteredItems = widget.items
            .where((item) => item.toLowerCase().contains(query))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 40.h,
              child: TextField(
                cursorHeight: 10,
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'بحث ',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Scrollbar(
                controller: scrollController,
                thumbVisibility: true,
                trackVisibility: true,
                radius: const Radius.circular(5),
                thickness: 5,
                scrollbarOrientation: ScrollbarOrientation.left,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: filteredItems.map((item) {
                      final isChecked = tempSelected.contains(item);
                      return CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        value: isChecked,
                        title: Text(item),
                        activeColor: AppColors.primaryColor,
                        onChanged: (checked) {
                          setState(() {
                            if (checked == true) {
                              // if (tempSelected.length < 2) {
                              //   tempSelected.add(item);
                              // } else {
                              //   // ممكن تضيف SnackBar أو Alert هنا
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       content: Text('مسموح باختيار عنصرين فقط'),
                              //       duration: Duration(seconds: 1),
                              //     ),
                              //   );
                              // }
                              tempSelected.add(item);
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
          ],
        ),
      ),
      actions: [
        SizedBox(
          height: 40.h,
          child: CustomButtonLarge(
            text: 'حفظ',
            color: AppColors.primaryColor,
            function: () => Navigator.of(context).pop(tempSelected),
          ),
        )
      ],
    );
  }
}

class _MultiSelectDatesDialog extends StatefulWidget {
  final List<String> selectedItems;
  final List<String> items;

  const _MultiSelectDatesDialog({
    required this.selectedItems,
    required this.items,
  });

  @override
  State<_MultiSelectDatesDialog> createState() =>
      _MultiSelectDatesDialogState();
}

class _MultiSelectDatesDialogState extends State<_MultiSelectDatesDialog> {
  late List<String> tempSelected;

  @override
  void initState() {
    super.initState();
    tempSelected = List.from(widget.selectedItems);
  }

  @override
  void dispose() {
    super.dispose();
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
          controller: scrollController,
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
                  controlAffinity: ListTileControlAffinity.leading,
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  value: isChecked,
                  title: Text(item),
                  activeColor: AppColors.primaryColor,
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
                        // if (tempSelected.length < 2) {
                        //   tempSelected.add(item);
                        // } else {
                        //   // ممكن تضيف SnackBar أو Alert هنا
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text('مسموح باختيار عنصرين فقط'),
                        //       duration: Duration(seconds: 1),
                        //     ),
                        //   );
                        // }
                        tempSelected.add(item);
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
        SizedBox(
          height: 40.h,
          child: CustomButtonLarge(
            text: 'حفظ',
            color: AppColors.primaryColor,
            function: () => Navigator.of(context).pop(tempSelected),
          ),
        )
      ],
    );
  }
}
