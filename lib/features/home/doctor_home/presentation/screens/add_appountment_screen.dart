import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/extensions/mediaQuery_extensions.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_shadows.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/cutom_button_large_dimmide.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_cubit.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_state.dart';
import 'package:ithera_app/features/home/doctor_home/presentation/widgets/add_date_form_field.dart';

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

  List<String> selectedItemsList = [];
  List<int> selectedItemsListIds = [];

  List<String> selectedDatesItemsList = [];
  List<int> selectedDatesItemsListIds = [];

  void toggleDay(String day) {
    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      } else {
        if (selectedDays.length < 3) {
          selectedDays.add(day);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('يمكنك اختيار ٣ أيام فقط')),
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
                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<BadeLookUpCubit, BadeLookUpState>(
                    builder: (context, state) {
                      return AddDateFormField(
                        isDates: false,
                        hintText: selectedItemsList.isEmpty
                            ? 'اختار منطقة '
                            : selectedItemsList.join(', '),
                        items: state.regions != null
                            ? state.regions!.map((e) => e.nameAr).toList()
                            : [],
                        isLoading:
                            state.specialtiesStatus == LookupStatus.loading,
                        selectedItems: selectedItemsList,
                        onSelectionChanged: (newSelected) {
                          setState(() {
                            selectedItemsList = newSelected;
                            selectedItemsList.map((e) {
                              selectedItemsListIds.add(state.regions!
                                  .firstWhere((element) => element.nameAr == e)
                                  .id);
                            }).toList();
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  AddDateFormField(
                    isDates: true,
                    hintText: selectedDatesItemsList.isEmpty
                        ? 'اختار السعات المتاحة لديك  '
                        : selectedDatesItemsList.join(', '),
                    isLoading: false,
                    items: [
                      '2-4 صباحاً',
                      '4-6 صباحاً',
                      '6-8 صباحاً',
                      '8-10 صباحاً',
                      '10-12 صباحاً',
                      '12-2 مساءاً',
                      '2-4 مساءاً',
                      '4-6 مساءاً',
                      '6-8 مساءاً',
                      '8-10 مساءاً',
                      '10-12 مساءاً',
                    ],
                    onSelectionChanged: (newDate) {
                      setState(() {
                        selectedDatesItemsList = newDate;
                        // selectedDatesItemsList.map((e) {
                        //   selectedItemsListIds.add(state.regions!
                        //       .firstWhere((element) => element.nameAr == e)
                        //       .id);
                        // }).toList();
                      });
                    },
                    selectedItems: selectedDatesItemsList,
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  selectedDays.isEmpty ||
                          selectedItemsList.isEmpty ||
                          selectedDatesItemsList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                              height: 40.h,
                              child:
                                  const CustomButtonLargeDimmed(text: 'أضافة')),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            height: 40.h,
                            child: CustomButtonLarge(
                                text: 'أضافة',
                                color: AppColors.primaryColor,
                                function: () {}),
                          ),
                        ),
                ]),
          )
        ],
      ),
    );
  }
}
