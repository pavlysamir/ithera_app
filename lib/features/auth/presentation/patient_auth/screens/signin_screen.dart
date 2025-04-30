import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/helpers/validation_handling.dart';
import 'package:ithera_app/core/routing/navigation_services.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_form_field.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/core/widgets/custom_text_rich.dart';
import 'package:ithera_app/core/widgets/cutom_button_large_dimmide.dart';
import 'package:ithera_app/features/auth/managers/patients_auth_cubit/patient_auth_cubit.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/custom_normal_rich_text.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key, required this.isFromPatient});

  final bool isFromPatient;

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formSignInScreenKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    CacheHelper.set(
      key: CacheConstants.isFromPatient,
      value: widget.isFromPatient,
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    phoneController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<PatientAuthCubit, PatientAuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
              child: Form(
            key: formSignInScreenKey,
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
                      'تسجيل الدخول',
                      style: AppTextStyles.font28Medium,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  widget.isFromPatient
                      ? SizedBox()
                      : Align(
                          alignment: Alignment.center,
                          child: Text('تسجيل الدخول كدكتور',
                              style: AppTextStyles.font12Regular
                                  .copyWith(color: AppColors.grey400)),
                        ),
                  SizedBox(
                    height: 24.h,
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
                      textInputType: TextInputType.number),
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomNormalRichText(
                    ischoosen: false,
                    firstText: 'كلمة المرور',
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  CustomFormField(
                      showEyeIcon: true,
                      controller: passwordController,
                      validate: conditionOfValidationPassWord,
                      hintText: '************',
                      textInputType: TextInputType.text),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: phoneController,
                    builder: (context, phoneValue, _) {
                      return ValueListenableBuilder<TextEditingValue>(
                        valueListenable: passwordController,
                        builder: (context, passwordValue, _) {
                          bool isEnabled = phoneValue.text.isNotEmpty &&
                              passwordValue.text.isNotEmpty;
                          return isEnabled
                              ? BlocConsumer<PatientAuthCubit,
                                  PatientAuthState>(
                                  listener: (context, state) {
                                    if (state is PatientLoginSuccess) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.green,
                                          content:
                                              Text('تم تسجيل الدخول بنجاح'),
                                        ),
                                      );
                                      NavigationService()
                                          .navigateAndRemoveUntil(
                                        Routes.patientHomeLayout,
                                      );
                                      // if (widget.isFromPatient) {
                                      //   CacheHelper.set(
                                      //     key: CacheConstants.isFromPatient,
                                      //     value: true,
                                      //   );

                                      // } else {
                                      //   CacheHelper.set(
                                      //     key: CacheConstants.isFromPatient,
                                      //     value: true,
                                      //   );
                                      // }
                                    }
                                    if (state is PatientLoginError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(state.errorMessage),
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return state is PatientLoginLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.primaryColor,
                                            ),
                                          )
                                        : CustomButtonLarge(
                                            text: 'تسجيل الدخول',
                                            textColor: Colors.white,
                                            function: () {
                                              if (formSignInScreenKey
                                                  .currentState!
                                                  .validate()) {
                                                PatientAuthCubit.get(context)
                                                    .login(
                                                  phoneNumber:
                                                      phoneController.text,
                                                  password:
                                                      passwordController.text,
                                                  isFromPatient:
                                                      widget.isFromPatient,
                                                );
                                              }
                                            },
                                            color: AppColors.primaryColor,
                                          );
                                  },
                                )
                              : CustomButtonLargeDimmed(text: 'تسجيل الدخول');
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomTextRich(
                        onSecondText: AppColors.primaryColor,
                        firstText: '',
                        secondText: 'هل نسيت كلمة المرور؟',
                        onSecondTextTap: () {
                          NavigationService()
                              .navigateTo(Routes.forgtPasswordScreen);
                        }),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomTextRich(
                        firstText: 'ليس لديك حساب  ؟ ',
                        secondText: 'انشاء حساب',
                        onSecondTextTap: () {
                          widget.isFromPatient
                              ? NavigationService()
                                  .navigateToReplacement(Routes.signUpScreen)
                              : NavigationService().navigateToReplacement(
                                  Routes.doctorSignUpScreen);
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
