import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/extensions/mediaQuery_extensions.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_shadows.dart';

class AddAppountmentScreen extends StatefulWidget {
  const AddAppountmentScreen({super.key});

  @override
  State<AddAppountmentScreen> createState() => _AddAppountmentScreenState();
}

class _AddAppountmentScreenState extends State<AddAppountmentScreen> {
  final List<String> weekDays = [
    'السبت',
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة'
  ];
  final List<String> selectedDays = [];

  void toggleDay(String day) {
    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      } else {
        if (selectedDays.length < 3) {
          selectedDays.add(day);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('يمكنك اختيار ٣ أيام فقط')),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: context.hightMediaQuery * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [AppShadows.shadow1],
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    height: 33.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: weekDays.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final day = weekDays[index];
                        final isSelected = selectedDays.contains(day);

                        return GestureDetector(
                          onTap: () => toggleDay(day),
                          child: Container(
                            width: 98.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.blueMoreLight,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.blueMoreLight,
                              ),
                            ),
                            child: Text(
                              day,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
