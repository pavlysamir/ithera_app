import 'package:flutter/material.dart';
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
import 'package:ithera_app/core/widgets/custom_toggle_isMale.dart';
import 'package:ithera_app/core/widgets/cutom_button_large_dimmide.dart';
import 'package:ithera_app/core/widgets/custom_drop_down_menu.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/custom_normal_rich_text.dart';

class PatientEditProfile extends StatefulWidget {
  const PatientEditProfile({super.key});

  @override
  State<PatientEditProfile> createState() => _PatientEditProfileState();
}

class _PatientEditProfileState extends State<PatientEditProfile> {
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
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.white,
          forceMaterialTransparency: true,
          elevation: 0,
        ),
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
                  const Align(
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
                      'تعديل حسابك',
                      style: AppTextStyles.font28Medium,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  const CustomNormalRichText(
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
                  const CustomNormalRichText(
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
                  const CustomNormalRichText(
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
                            const CustomNormalRichText(
                              ischoosen: false,
                              firstText: 'المدينة',
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            CustomDropDownMenu(
                              items: [
                                'الزيتون',
                                'النزهة الجديدة',
                                'مدينة نصر',
                                'مصر الجديدة'
                              ],
                              onChange: (newValue) {
                                setState(() {
                                  selectedValueCity = newValue;
                                });
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
                            const CustomNormalRichText(
                              ischoosen: false,
                              firstText: 'المنطقة',
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            CustomDropDownMenu(
                              items: [
                                'أسيوط',
                                'سوهاج',
                                'الاسكندرية',
                                'القاهرة'
                              ],
                              onChange: (newValue) {
                                setState(() {
                                  selectedValueRegion = newValue;
                                });
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
                      ? const CustomButtonLargeDimmed(
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
                ],
              ),
            ),
          )),
        ));
  }
}
