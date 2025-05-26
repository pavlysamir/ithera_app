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
import 'package:ithera_app/features/home/doctor_home/managers/cubit/doctor_manage_schedules_cubit.dart';
import 'package:ithera_app/features/home/doctor_home/presentation/widgets/add_date_form_field.dart';
import 'package:ithera_app/features/home/doctor_home/presentation/widgets/custom_calender_field.dart';

class AddAppountmentScreen extends StatefulWidget {
  const AddAppountmentScreen({super.key});

  @override
  State<AddAppountmentScreen> createState() => _AddAppountmentScreenState();
}

class _AddAppountmentScreenState extends State<AddAppountmentScreen> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2100),
      locale: const Locale('ar', ''), // لعرض التاريخ بالعربي
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
        print(selectedDays);
      } else {
        if (selectedDays.length < 3) {
          selectedDays.add(day);
          print(selectedDays);
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
            height: context.hightMediaQuery * 0.4,
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
                    items: const [
                      '10-12 صباحاً',
                      '11-1 صباحاً',
                      '12-2 مساءاً',
                      '1-3 مساءاً',
                      '2-4 مساءاً',
                      '3-5 مساءاً',
                      '4-6 مساءاً',
                      '5-7 مساءاً',
                      '6-8 مساءاً',
                      '7-9 مساءاً',
                      '8-10 مساءاً',
                      '9-11 مساءاً',
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
                    height: 11,
                  ),
                  DatePickerField(
                    onDateSelected: _selectDate,
                    selectedDate: selectedDate,
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  selectedDays.isEmpty ||
                          selectedItemsList.isEmpty ||
                          selectedDatesItemsList.isEmpty ||
                          selectedDate == null
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
                            child: BlocConsumer<DoctorManageSchedulesCubit,
                                DoctorManageSchedulesState>(
                              listener: (context, state) {
                                if (state is DoctorManageSchedulesSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text('تم الاضافة بنجاح')));
                                } else if (state
                                    is DoctorManageSchedulesError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(state.errorMessage)));
                                }
                              },
                              builder: (context, state) {
                                var cubit =
                                    DoctorManageSchedulesCubit.get(context);

                                return state is DoctorManageSchedulesLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                        ),
                                      )
                                    : CustomButtonLarge(
                                        text: 'أضافة',
                                        color: AppColors.primaryColor,
                                        function: () async {
                                          await cubit
                                              .manageSchedulesBooking(
                                            selectedDate: selectedDate!,
                                            selectedDays: selectedDays,
                                            timeRanges: selectedDatesItemsList,
                                            selectedRegionIds:
                                                selectedItemsListIds,
                                          )
                                              .then((context) {
                                            setState(() {
                                              selectedDate = null;
                                              selectedDatesItemsListIds.clear();
                                              selectedDatesItemsList.clear();
                                              selectedItemsListIds.clear();
                                              selectedItemsList.clear();
                                              selectedDays.clear();
                                            });
                                          });
                                        });
                              },
                            ),
                          ),
                        ),
                ]),
          )
        ],
      ),
    );
  }
}
