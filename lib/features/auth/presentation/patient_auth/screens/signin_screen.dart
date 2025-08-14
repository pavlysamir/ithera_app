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
import 'package:ithera_app/features/add_files/manager/cubit/add_files_cubit.dart';
import 'package:ithera_app/features/auth/managers/patients_auth_cubit/patient_auth_cubit.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/custom_normal_rich_text.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key, required this.isFromPatient});

  final bool isFromPatient;

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formSignInScreenKey;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    formSignInScreenKey = GlobalKey<FormState>();

    // Add listeners to controllers
    phoneController.addListener(_updateFormState);
    passwordController.addListener(_updateFormState);

    // Use post frame callback for cache operations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CacheHelper.set(
        key: CacheConstants.isFromPatient,
        value: widget.isFromPatient,
      );
    });
  }

  void _updateFormState() {
    final isValid =
        phoneController.text.isNotEmpty && passwordController.text.isNotEmpty;
    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  void dispose() {
    phoneController.removeListener(_updateFormState);
    passwordController.removeListener(_updateFormState);
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<PatientAuthCubit, PatientAuthState>(
          listener: (context, state) {
            if (state is PatientLoginSuccess) {
              // Use post frame callback for navigation to avoid build conflicts
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('تم تسجيل الدخول بنجاح'),
                  ),
                );

                await context.read<AddFilesCubit>().getFile(
                      fileId: 3,
                      roleId: widget.isFromPatient ? 2 : 1,
                    );
                NavigationService().navigateAndRemoveUntil(
                  Routes.patientHomeLayout,
                );
              });
            }
            if (state is PatientLoginError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.errorMessage),
                  ),
                );
              });
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              physics:
                  const ClampingScrollPhysics(), // Use clamping physics to avoid overscroll issues
              child: Form(
                key: formSignInScreenKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      const Align(
                        alignment: Alignment.center,
                        child: CustomSvgimage(
                          hight: 70,
                          path: AssetsData.logoBlue,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'تسجيل الدخول',
                          style: AppTextStyles.font28Medium,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      if (!widget.isFromPatient)
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'تسجيل الدخول كدكتور',
                            style: AppTextStyles.font12Regular
                                .copyWith(color: AppColors.grey400),
                          ),
                        ),
                      SizedBox(height: 24.h),
                      const CustomNormalRichText(
                        ischoosen: false,
                        firstText: 'رقم الموبيل',
                      ),
                      SizedBox(height: 18.h),
                      CustomFormField(
                        controller: phoneController,
                        validate: conditionOfValidationPhone,
                        hintText: '01000000000',
                        textInputType: TextInputType.number,
                      ),
                      SizedBox(height: 32.h),
                      const CustomNormalRichText(
                        ischoosen: false,
                        firstText: 'كلمة المرور',
                      ),
                      SizedBox(height: 18.h),
                      CustomFormField(
                        showEyeIcon: true,
                        controller: passwordController,
                        validate: conditionOfValidationPassWord,
                        hintText: '************',
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),

                      // Simplified button logic without nested ValueListenableBuilder
                      _buildLoginButton(state),

                      SizedBox(height: 50.h),
                      Align(
                        alignment: Alignment.center,
                        child: CustomTextRich(
                          onSecondText: AppColors.primaryColor,
                          firstText: '',
                          secondText: 'هل نسيت كلمة المرور؟',
                          onSecondTextTap: () {
                            NavigationService()
                                .navigateTo(Routes.forgtPasswordScreen);
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
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
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoginButton(PatientAuthState state) {
    if (state is PatientLoginLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      );
    }

    if (_isFormValid) {
      return BlocBuilder<AddFilesCubit, AddFilesState>(
        builder: (context, state) {
          return CustomButtonLarge(
            text: 'تسجيل الدخول',
            textColor: Colors.white,
            color: AppColors.primaryColor,
            function: () {
              if (formSignInScreenKey.currentState!.validate()) {
                PatientAuthCubit.get(context).login(
                  phoneNumber: phoneController.text,
                  password: passwordController.text,
                  isFromPatient: widget.isFromPatient,
                );
              }
            },
          );
        },
      );
    }

    return const CustomButtonLargeDimmed(
      text: 'تسجيل الدخول',
    );
  }
}
