import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/routing/navigation_services.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/features/auth/managers/patients_auth_cubit/patient_auth_cubit.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/count_down_timer.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/custom_smooth_indicaror.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhoneOtpRegisterScreen extends StatefulWidget {
  const VerifyPhoneOtpRegisterScreen({
    super.key,
    required this.isFromForgetPassword,
  });
  final bool isFromForgetPassword;

  @override
  State<VerifyPhoneOtpRegisterScreen> createState() =>
      _VerifyPhoneOtpRegisterScreenState();
}

class _VerifyPhoneOtpRegisterScreenState
    extends State<VerifyPhoneOtpRegisterScreen> {
  late TextEditingController verifyOtPhoneController;
  final formVerifyOtpPhoneKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    verifyOtPhoneController = TextEditingController();
  }

  @override
  void dispose() {
    // verifyOtPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PatientAuthCubit, PatientAuthState>(
          builder: (context, state) {
            return SingleChildScrollView(
                child: Form(
              key: formVerifyOtpPhoneKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 46.w),
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
                        'تأكيد رقم الموبيل',
                        style: AppTextStyles.font28Medium,
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    const Center(
                      child: CustomSmoothIndicator(
                        activeIndex: 1,
                        count: 3,
                      ),
                    ),
                    SizedBox(
                      height: 41.h,
                    ),
                    Center(
                      child: Text(
                        CacheHelper.getString(key: CacheConstants.userPhone) ??
                            '',
                        style: AppTextStyles.font20Regular.copyWith(
                          color: AppColors.textGreen,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    // Center(
                    //     child: TextButton(
                    //   onPressed: () {},
                    //   child: Text(
                    //     AppLocalizations.of(context)!.changePhoneNumber,
                    //     style: const TextStyle(
                    //         decoration: TextDecoration.underline,
                    //         color: kPrimaryKey),
                    //   ),
                    // )),

                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: PinCodeTextField(
                          keyboardType: TextInputType.number,
                          cursorColor: Theme.of(context).indicatorColor,
                          appContext: context,
                          length: 6,
                          controller: verifyOtPhoneController,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'otpادخل ال';
                            }
                            return null;
                          },
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 40.h,
                              fieldWidth: 32.w,
                              activeColor: Colors.grey,
                              selectedColor: Colors.grey,
                              inactiveColor: Colors.grey,
                              activeFillColor: Colors.white,
                              selectedFillColor: Colors.grey[200],
                              inactiveFillColor: Colors.grey[100],
                              errorBorderColor: Colors.red),
                          textStyle: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    const Center(child: CountdownButton()),
                    SizedBox(
                      height: 3.h,
                    ),
                    // state is ResendOtpLoading
                    //     ? const Center(
                    //         child: CircularProgressIndicator(
                    //           strokeWidth: 2,
                    //           color: kPrimaryKey,
                    //         ),
                    //       )
                    //     : Center(
                    //         child: TextButton(
                    //         onPressed: () {
                    //           RegisterCubit.get(context)!.verifyMobileNum();
                    //         },
                    //         child: const Text(
                    //           'Resend',
                    //           style: TextStyle(
                    //               decoration: TextDecoration.underline,
                    //               color: kDarktBlue),
                    //         ),
                    //       )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    // state is VerifyOtpMobileNumLoading ||
                    //         state is GetAllSubjectsRegistrationLoading
                    //     ? const Center(
                    //         child: CircularProgressIndicator(
                    //           color: kPrimaryKey,
                    //         ),
                    //       )
                    //     :

                    CustomButtonLarge(
                      text: 'تأكيد',
                      textColor: Colors.white,
                      function: () async {
                        if (formVerifyOtpPhoneKey.currentState!.validate()) {
                          //RegisterCubit.get(context)!.verifyOtpMobileNum();

                          NavigationService().navigateAndRemoveUntil(
                              Routes.addPassasswordScreen,
                              arguments: widget.isFromForgetPassword);
                        }
                      },
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ));
          },
        ),
      ),
    );
  }
}
