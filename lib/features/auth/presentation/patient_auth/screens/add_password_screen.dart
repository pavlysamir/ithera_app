import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

class AddPasswordScreen extends StatefulWidget {
  const AddPasswordScreen({super.key, required this.isFromForgetPassword});
  final bool isFromForgetPassword;
  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordasswordController =
      TextEditingController();

  var formAddPasswordPhoneKey = GlobalKey<FormState>();
  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
            key: formAddPasswordPhoneKey,
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
                          widget.isFromForgetPassword
                              ? 'إعادة تعيين كلمة المرور'
                              : 'انشاء حساب',
                          style: AppTextStyles.font28Medium,
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
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
                          textInputType: TextInputType.visiblePassword),
                      SizedBox(
                        height: 32.h,
                      ),
                      CustomNormalRichText(
                        ischoosen: false,
                        firstText: 'تأكيد كلمة المرور',
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      CustomFormField(
                          showEyeIcon: true,
                          controller: confirmPasswordasswordController,
                          validate: (value) {
                            if (value == passwordController.text) {
                              return null;
                            } else {
                              return 'does\'t match ';
                            }
                          },
                          hintText: '************',
                          textInputType: TextInputType.visiblePassword),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      passwordController.text.isEmpty ||
                              confirmPasswordasswordController.text.isEmpty
                          ? CustomButtonLargeDimmed(
                              text: 'تسجيل الدخول',
                            )
                          : BlocConsumer<PatientAuthCubit, PatientAuthState>(
                              listener: (context, state) {
                                if (state is PatientAuthSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text('تم تسجيل الدخول بنجاح'),
                                    ),
                                  );
                                  NavigationService().navigateAndRemoveUntil(
                                      arguments: true, Routes.signInScreen);
                                } else if (state is PatientAuthError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(state.errorMessage),
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return state is PatientAuthLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                        ),
                                      )
                                    : CustomButtonLarge(
                                        text: 'تسجيل الدخول',
                                        textColor: Colors.white,
                                        function: () async {
                                          if (formAddPasswordPhoneKey
                                              .currentState!
                                              .validate()) {
                                            // Delay the state-changing operations until after the current frame
                                            SchedulerBinding.instance
                                                .addPostFrameCallback((_) {
                                              CacheHelper.set(
                                                key: CacheConstants.password,
                                                value: passwordController.text,
                                              ).then((value) {
                                                PatientAuthCubit.get(context)
                                                    .patientSignUp();
                                              });
                                            });
                                          }
                                        },
                                        color: AppColors.primaryColor,
                                      );
                              },
                            ),
                      SizedBox(
                        height: 50.h,
                      ),
                      // widget.isFromForgetPassword
                      //     ? SizedBox()
                      //     : Align(
                      //         alignment: Alignment.center,
                      //         child: CustomTextRich(
                      //             firstText: 'بالفعل لديك حساب ؟ ',
                      //             secondText: 'تسجيل الدخول',
                      //             onSecondTextTap: () {
                      //               NavigationService()
                      //                   .navigateTo(Routes.signInScreen);
                      //             }),
                      //       ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ]))),
      )),
    );
  }
}

enum FromWhat {
  fromForgetPassword,
  fromDoctorSignUp,
  fromPatientSignUp,
}
