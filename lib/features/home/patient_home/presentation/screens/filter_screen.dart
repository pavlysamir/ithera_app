import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_drop_down_menu.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/core/widgets/custom_toggle_isMale.dart';
import 'package:ithera_app/core/widgets/cutom_button_large_dimmide.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final TextEditingController controller = TextEditingController();

  String? selectedValueCity;
  String? selectedValueSpeciality;
  bool? isMale;

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
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.primaryColor,
                          ))),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'ابحث عن دكتور من خلال المنطقة او التخصص الذي تحتاجه',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font12Regular,
              ),
              SizedBox(height: 32),
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
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Row(
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomSvgimage(
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
              SizedBox(height: 28),
              Text(
                'المنطقة',
                style:
                    AppTextStyles.font16Regular.copyWith(color: Colors.black),
              ),
              SizedBox(height: 16),
              CustomDropDownMenu(
                items: ['القاهرة', 'الجيزة'],
                onChange: (newValue) {
                  setState(() {
                    selectedValueCity = newValue;
                  });
                },
              ),
              SizedBox(height: 16),
              Text(
                'التخصص',
                style:
                    AppTextStyles.font16Regular.copyWith(color: Colors.black),
              ),
              SizedBox(height: 16),
              CustomDropDownMenu(
                items: ['اختر التخصص'],
                onChange: (newValue) {
                  setState(() {
                    selectedValueSpeciality = newValue;
                  });
                },
              ),
              SizedBox(height: 16),
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
                      selectedValueSpeciality != null ||
                      isMale != null
                  ? CustomButtonLarge(
                      text: 'بحث',
                      textColor: Colors.white,
                      function: () {
                        // NavigationService().navigateToReplacement(
                        //     Routes.verifyOtpScreen,
                        //     arguments: false);
                      },
                      color: AppColors.primaryColor,
                    )
                  : CustomButtonLargeDimmed(
                      text: 'بحث',
                    ),
            ],
          ),
        ),
      ),
    ));
  }
}
