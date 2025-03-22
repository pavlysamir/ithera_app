import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/helpers/validation_handling.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_form_field.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/core/widgets/custom_text_rich.dart';
import 'package:ithera_app/features/auth/patient_auth/presentation/widgets/custom_drop_down_menu.dart';
import 'package:ithera_app/features/auth/patient_auth/presentation/widgets/custom_normal_rich_text.dart';
import 'package:ithera_app/features/auth/patient_auth/presentation/widgets/custom_smooth_indicaror.dart';

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

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
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
                  validationMassage: conditionOfValidationName,
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
                  validationMassage: conditionOfValidationPhone,
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
                  validationMassage: conditionOfValidationPhone,
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
                        CustomDropDownMenu(
                          items: ['الاثائة', 'الاثائة', 'الاثائة', 'الاثائة'],
                          onChange: (p0) {
                            print(p0);
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
                        CustomDropDownMenu(
                          items: ['الاثائة', 'الاثائة', 'الاثائة', 'الاثائة'],
                          onChange: (p0) {
                            print(p0);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              CustomButtonLarge(
                text: 'التالي',
                textColor: Colors.white,
                function: () {},
                color: AppColors.primaryColor,
              ),
              SizedBox(
                height: 50.h,
              ),
              CustomTextRich(
                  firstText: 'بالفعل لديك حساب ؟ ',
                  secondText: 'تسجيل الدخول',
                  onSecondTextTap: () {}),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      )),
    ));
  }
}
