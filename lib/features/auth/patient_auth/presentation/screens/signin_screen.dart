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
import 'package:ithera_app/core/widgets/cutom_button_large_dimmide.dart';
import 'package:ithera_app/features/auth/patient_auth/managers/cubit/patient_auth_cubit.dart';
import 'package:ithera_app/features/auth/patient_auth/presentation/widgets/custom_normal_rich_text.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formSignInScreenKey = GlobalKey<FormState>();

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
                              ? CustomButtonLarge(
                                  text: 'تسجيل الدخول',
                                  textColor: Colors.white,
                                  function: () {
                                    NavigationService()
                                        .navigateTo(Routes.patientHomeLayout);
                                  },
                                  color: AppColors.primaryColor,
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
                          NavigationService()
                              .navigateToReplacement(Routes.signUpScreen);
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
