import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/helpers/validation_handling.dart';
import 'package:ithera_app/core/routing/navigation_services.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_form_field.dart';
import 'package:ithera_app/core/widgets/custom_multi_select_dropdown.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/core/widgets/custom_text_rich.dart';
import 'package:ithera_app/core/widgets/custom_toggle_isMale.dart';
import 'package:ithera_app/core/widgets/cutom_button_large_dimmide.dart';
import 'package:ithera_app/features/auth/managers/doctor_auth_cubit/doctor_auth_cubit.dart';
import 'package:ithera_app/core/widgets/custom_drop_down_menu.dart';
import 'package:ithera_app/features/auth/presentation/doctor_auth/widgets/circular_profile_img.dart';
import 'package:ithera_app/features/auth/presentation/doctor_auth/widgets/custom_import_image_field.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/custom_normal_rich_text.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/custom_smooth_indicaror.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_cubit.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_state.dart';

class DoctorSignupScreen extends StatefulWidget {
  const DoctorSignupScreen({super.key});

  @override
  State<DoctorSignupScreen> createState() => _DoctorSignUpScreenState();
}

class _DoctorSignUpScreenState extends State<DoctorSignupScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController anotherPhoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  var formSignUpScreenKey = GlobalKey<FormState>();

  String? selectSpicification;
  String? selectedValueRegion;
  File? profileImagePath;
  File? karnehImagePath;
  String? karnehImageName;

  List<String> selectedItemsList = [];
  bool? isMale;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<DoctorAuthCubit, DoctorAuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
              child: Form(
            key: formSignUpScreenKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomSvgimage(
                      hight: 70,
                      path: AssetsData.logoBlue,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'انشاء حساب',
                      style: AppTextStyles.font28Medium,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const Center(
                    child: CustomSmoothIndicator(
                      activeIndex: 2,
                      count: 3,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CircularProfileImage(
                    closeFunction: () {
                      //   BlocProvider.of<DoctorAuthCubit>(context).deleteImage();
                      setState(() {
                        profileImagePath = null;
                      });
                    },
                    file: profileImagePath,
                    function: () {
                      BlocProvider.of<DoctorAuthCubit>(context)
                          .pickCameraImage()
                          .then((value) {
                        profileImagePath =
                            BlocProvider.of<DoctorAuthCubit>(context).file;
                      });
                    },
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        'برجاء رفع صورة بالبالطو الابيض وخلفية سادة خلف الدكتور',
                        style: AppTextStyles.font10Regular),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomNormalRichText(
                    ischoosen: false,
                    firstText: 'الأسم',
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  CustomFormField(
                      controller: nameController,
                      validate: conditionOfValidationName,
                      hintText: 'الأسم ثنائي',
                      textInputType: TextInputType.text),
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomNormalRichText(
                    ischoosen: false,
                    firstText: 'رقم الموبيل',
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomFormField(
                      controller: phoneController,
                      validate: conditionOfValidationPhone,
                      hintText: '01000000000',
                      textInputType: TextInputType.phone),
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomNormalRichText(
                    ischoosen: true,
                    firstText: 'رقم موبايل آخر',
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  CustomFormField(
                      controller: anotherPhoneController,
                      validate: conditionOfValidationPhone,
                      hintText: '01000000000',
                      textInputType: TextInputType.phone),
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomNormalRichText(
                    ischoosen: true,
                    firstText: 'إيميل',
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  CustomFormField(
                      controller: emailController,
                      validate: conditionOfValidationPhone,
                      hintText: 'name@gmail.com',
                      textInputType: TextInputType.emailAddress),
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomNormalRichText(
                    ischoosen: false,
                    firstText: 'المحافظة',
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  BlocBuilder<BadeLookUpCubit, BadeLookUpState>(
                    builder: (context, state) {
                      return CustomDropDownMenu(
                        isLoading: state.citiesStatus == LookupStatus.loading,
                        items: state.cities != null
                            ? state.cities!.map((e) => e.nameAr).toList()
                            : [],
                        onChange: (newValue) {
                          setState(() {
                            selectedValueRegion = newValue;
                          });
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomNormalRichText(
                    ischoosen: false,
                    firstText: 'التخصص (اثنين بحد اقصى)',
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  BlocBuilder<BadeLookUpCubit, BadeLookUpState>(
                    builder: (context, state) {
                      return CustomMultiSelectDropDown(
                        items: state.specialties != null
                            ? state.specialties!.map((e) => e.nameAr).toList()
                            : [],
                        isLoading:
                            state.specialtiesStatus == LookupStatus.loading,
                        selectedItems: selectedItemsList,
                        onSelectionChanged: (newSelected) {
                          setState(() {
                            selectedItemsList = newSelected;
                          });
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomNormalRichText(
                    ischoosen: false,
                    firstText: 'صورة كارنيه النقابة ( سارى)',
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  CustomImportImageField(onTap: () {
                    BlocProvider.of<DoctorAuthCubit>(context)
                        .pickCameraImage()
                        .then((value) {
                      karnehImagePath =
                          BlocProvider.of<DoctorAuthCubit>(context).file;
                      karnehImageName =
                          BlocProvider.of<DoctorAuthCubit>(context).fileName;
                    });
                  }),
                  karnehImageName != null
                      ? Padding(
                          padding: EdgeInsets.only(left: 8.w, top: 8.h),
                          child: Center(
                            child: Text(
                              karnehImageName!,
                              style: AppTextStyles.font12Regular.copyWith(
                                  color: AppColors.primaryColor,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomToggleisMale(
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
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  nameController.text.isEmpty ||
                          phoneController.text.isEmpty ||
                          selectSpicification == null ||
                          selectedValueRegion == null ||
                          isMale == null
                      ? CustomButtonLargeDimmed(
                          text: 'التالي',
                        )
                      : CustomButtonLarge(
                          text: 'التالي',
                          textColor: Colors.white,
                          function: () {
                            NavigationService().navigateToReplacement(
                                Routes.verifyOtpScreen,
                                arguments: false);
                          },
                          color: AppColors.primaryColor,
                        ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomTextRich(
                        firstText: 'بالفعل لديك حساب ؟ ',
                        secondText: 'تسجيل الدخول',
                        onSecondTextTap: () {
                          NavigationService().navigateTo(Routes.signInScreen);
                        }),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ));
        },
      ),
    ));
  }
}
