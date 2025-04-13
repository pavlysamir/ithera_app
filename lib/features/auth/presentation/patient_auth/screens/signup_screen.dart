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
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/core/widgets/custom_text_rich.dart';
import 'package:ithera_app/core/widgets/custom_toggle_isMale.dart';
import 'package:ithera_app/core/widgets/cutom_button_large_dimmide.dart';
import 'package:ithera_app/features/auth/managers/patients_auth_cubit/patient_auth_cubit.dart';
import 'package:ithera_app/core/widgets/custom_drop_down_menu.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/custom_normal_rich_text.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/custom_smooth_indicaror.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_cubit.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  var formSignUpScreenKey = GlobalKey<FormState>();

  String? selectedValueCity;
  String? selectedValueRegion;
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
      child: BlocBuilder<PatientAuthCubit, PatientAuthState>(
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
                    height: 16.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'انشاء حساب',
                      style: AppTextStyles.font28Medium,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
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
                    height: 18.h,
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
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomNormalRichText(
                              ischoosen: false,
                              firstText: 'المدينة',
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            BlocBuilder<BadeLookUpCubit, BadeLookUpState>(
                              builder: (context, state) {
                                return CustomDropDownMenu(
                                  isLoading: state.citiesStatus ==
                                      LookupStatus.loading,
                                  items: state.cities == null
                                      ? []
                                      : state.cities!
                                          .map((e) => e.nameAr)
                                          .toList(),
                                  onChange: (newValue) {
                                    setState(() {
                                      selectedValueCity = newValue;
                                    });
                                    BlocProvider.of<BadeLookUpCubit>(context)
                                        .getAllRegions(state.cities!
                                            .firstWhere((element) =>
                                                element.nameAr == newValue)
                                            .id);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomNormalRichText(
                              ischoosen: false,
                              firstText: 'المنطقة',
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            BlocBuilder<BadeLookUpCubit, BadeLookUpState>(
                              builder: (context, state) {
                                return selectedValueCity == null
                                    ? Text('برجاء اختيار المدينة أولا')
                                    : CustomDropDownMenu(
                                        isLoading: state.regionsStatus ==
                                            LookupStatus.loading,
                                        items: state.regions == null
                                            ? []
                                            : state.regions!
                                                .map((e) => e.nameAr)
                                                .toList(),
                                        onChange: (newValue) {
                                          setState(() {
                                            selectedValueRegion = newValue;
                                          });
                                        },
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                          selectedValueCity == null ||
                          selectedValueRegion == null ||
                          isMale == null
                      ? CustomButtonLargeDimmed(
                          text: 'التالي',
                        )
                      : CustomButtonLarge(
                          text: 'التالي',
                          textColor: Colors.white,
                          function: () {
                            BlocProvider.of<PatientAuthCubit>(context)
                                .cashedUserDataFirstScreen(
                              userName: nameController.text,
                              userEmail: emailController.text,
                              userPhone: phoneController.text,
                              cityId: selectedValueCity!,
                              regionId: selectedValueRegion!,
                              genderId: isMale! ? '1' : '2',
                            )
                                .then((value) {
                              NavigationService().navigateToReplacement(
                                  Routes.verifyOtpScreen,
                                  arguments: false);
                            });
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
