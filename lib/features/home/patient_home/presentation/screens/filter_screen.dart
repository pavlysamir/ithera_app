import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/routing/navigation_services.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_drop_down_menu.dart';
import 'package:ithera_app/core/widgets/custom_multi_select_dropdown.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/core/widgets/custom_toggle_isMale.dart';
import 'package:ithera_app/core/widgets/cutom_button_large_dimmide.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_cubit.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_state.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final TextEditingController controller = TextEditingController();

  String? selectedValueCity;
  String? selectedValueSpeciality;
  int? cityId;
  bool? isMale;
  List<String> selectedItemsList = [];
  List<int> selectedItemsListIds = [];
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'البحث عن الدكتور\nالمناسب لك',
                    style: AppTextStyles.font20Regular.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.primaryColor,
                          ))),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'ابحث عن دكتور من خلال المنطقة او التخصص الذي تحتاجه',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font12Regular,
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 60.h,
                child: TextFormField(
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    hintText: 'ابحث عن دكتورك بالأسم',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: Row(
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        const CustomSvgimage(
                          path: 'assets/icons/search_icon.svg',
                          hight: 25,
                        ),
                      ],
                    ),
                    prefixIconConstraints: BoxConstraints(
                      maxHeight: 25.h,
                      maxWidth: 50.w,
                    ),
                    // suffixIcon: Row(
                    //   children: [
                    //     IconButton(
                    //       icon: CustomSvgimage(
                    //         hight: 40.h,
                    //         path: 'assets/icons/filter_icon.svg',
                    //       ),
                    //       onPressed: () {
                    //         //controller.clear();
                    //       },
                    //     ),
                    //     SizedBox(
                    //       width: 10.w,
                    //     ),
                    //   ],
                    // ),
                    suffixIconConstraints: BoxConstraints(
                      maxHeight: 50.h,
                      maxWidth: 60.w,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'المنطقة',
                style:
                    AppTextStyles.font16Regular.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 16),
              BlocBuilder<BadeLookUpCubit, BadeLookUpState>(
                builder: (context, state) {
                  return CustomDropDownMenu(
                    isLoading: state.citiesStatus == LookupStatus.loading,
                    items: state.cities != null
                        ? state.cities!.map((e) => e.nameAr).toList()
                        : [],
                    onChange: (newValue) {
                      setState(() {
                        selectedValueCity = newValue;
                        cityId = state.cities!
                            .firstWhere((element) => element.nameAr == newValue)
                            .id;
                        print(cityId);
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              Text(
                'التخصص',
                style:
                    AppTextStyles.font16Regular.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 16),
              BlocBuilder<BadeLookUpCubit, BadeLookUpState>(
                builder: (context, state) {
                  return CustomMultiSelectDropDown(
                    items: state.specialties != null
                        ? state.specialties!.map((e) => e.nameAr).toList()
                        : [],
                    isLoading: state.specialtiesStatus == LookupStatus.loading,
                    selectedItems: selectedItemsList,
                    onSelectionChanged: (newSelected) {
                      setState(() {
                        selectedItemsList = newSelected;
                        selectedItemsList.map((e) {
                          selectedItemsListIds.add(state.specialties!
                              .firstWhere((element) => element.nameAr == e)
                              .id);
                        }).toList();
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              CustomToggleisMale(
                fromAuth: false,
                isMale: isMale,
                onMaleTap: () {
                  setState(() {
                    if (isMale == null) {
                      isMale = true;
                    } else {
                      isMale = null;
                    }

                    print(isMale);
                  });
                },
                onFemaleTap: () {
                  setState(() {
                    if (isMale == null) {
                      isMale = false;
                    } else {
                      isMale = null;
                    }
                    print(isMale);
                  });
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              controller.text.isNotEmpty ||
                      selectedValueCity != null ||
                      selectedItemsList.isNotEmpty ||
                      isMale != null
                  ? CustomButtonLarge(
                      text: 'بحث',
                      textColor: Colors.white,
                      function: () {
                        print(
                            'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${controller.text.trim()}');
                        NavigationService().navigateToReplacement(
                          Routes.resultFilterScreen,
                          arguments: {
                            'doctorName': controller.text.trim(),
                            'cityId': cityId,
                            'specialtyId': selectedItemsListIds.isNotEmpty
                                ? selectedItemsListIds.first
                                : null,
                            'gender': isMale,
                          },
                        );
                      },
                      color: const Color.fromRGBO(0, 122, 255, 1),
                    )
                  : const CustomButtonLargeDimmed(
                      text: 'بحث',
                    ),
            ],
          ),
        ),
      ),
    ));
  }
}
