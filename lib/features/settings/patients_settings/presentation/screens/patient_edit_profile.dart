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
import 'package:ithera_app/core/widgets/custom_toggle_isMale.dart';
import 'package:ithera_app/core/widgets/cutom_button_large_dimmide.dart';
import 'package:ithera_app/core/widgets/custom_drop_down_menu.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/custom_normal_rich_text.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_cubit.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_state.dart';
import 'package:ithera_app/features/settings/patients_settings/managers/cubit/seetings_cubit.dart';

class PatientEditProfile extends StatefulWidget {
  const PatientEditProfile({super.key});

  @override
  State<PatientEditProfile> createState() => _PatientEditProfileState();
}

class _PatientEditProfileState extends State<PatientEditProfile> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  var formPatientDataScreenKey = GlobalKey<FormState>();

  String? selectedValueCity;
  String? selectedValueRegion;

  int? cityId;

  int? regionId;
  bool? isMale;

  bool _isFormInitialized = false;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final settingState = context.read<SettingsCubit>().state;
    if (!_isFormInitialized && settingState is PatientDataLoaded) {
      final data = settingState.patientDataModel;

      nameController.text = data.name;
      phoneController.text = data.mobileNumber ?? '';
      emailController.text = data.email ?? '';
      cityId = data.cityId;
      isMale = data.gender == 1 ? true : false;
      regionId = data.regionId;

      _isFormInitialized = true;
    }
  }

  @override
  void initState() {
    super.initState();

    context.read<SettingsCubit>().getPatientData();
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
          child: BlocConsumer<SettingsCubit, SeetingsState>(
            listener: (context, state) {
              if (state is PatientDataLoaded) {
                final data = state.patientDataModel;

                nameController.text = data.name;
                phoneController.text = data.mobileNumber ?? '';
                emailController.text = data.email ?? '';
                cityId = data.cityId;
                isMale = data.gender == 1 ? true : false;
                regionId = data.regionId;

                context.read<BadeLookUpCubit>().getAllRegions(
                      cityId ?? 0,
                    );
              }
            },
            builder: (context, state) {
              if (state is PatientDataLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }

              if (state is PatientDataError) {
                return const Center(child: Text("فشل في تحميل البيانات"));
              }

              return SingleChildScrollView(
                  child: Form(
                key: formPatientDataScreenKey,
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
                                BlocBuilder<BadeLookUpCubit, BadeLookUpState>(
                                  builder: (context, state) {
                                    return CustomDropDownMenu(
                                      isLoading: state.citiesStatus ==
                                          LookupStatus.loading,
                                      items: state.cities
                                              ?.map((e) => e.nameAr)
                                              .toList() ??
                                          [],
                                      initialValue: state.cities
                                          ?.firstWhere(
                                            (e) => e.id == cityId,
                                            orElse: () => state.cities!.first,
                                          )
                                          .nameAr,
                                      onChange: (newValue) {
                                        setState(() {
                                          selectedValueCity = newValue;
                                          cityId = state.cities!
                                              .firstWhere(
                                                  (e) => e.nameAr == newValue)
                                              .id;
                                        });
                                        context
                                            .read<BadeLookUpCubit>()
                                            .getAllRegions(
                                              cityId ?? 0,
                                            );
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
                                const CustomNormalRichText(
                                  ischoosen: false,
                                  firstText: 'المنطقة',
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                BlocBuilder<BadeLookUpCubit, BadeLookUpState>(
                                  builder: (context, state) {
                                    return CustomDropDownMenu(
                                      isLoading: state.regionsStatus ==
                                          LookupStatus.loading,
                                      items: state.regions
                                              ?.map((e) => e.nameAr)
                                              .toList() ??
                                          [],
                                      initialValue: state.regions?.firstWhere(
                                        (e) => e.id == regionId,
                                        orElse: () {
                                          context
                                              .read<BadeLookUpCubit>()
                                              .getAllRegions(
                                                cityId ?? 0,
                                              );
                                          return state.regions!.first;
                                        },
                                      ).nameAr,
                                      onChange: (newValue) {
                                        setState(() {
                                          selectedValueRegion = newValue;
                                          regionId = state.regions!
                                              .firstWhere(
                                                  (e) => e.nameAr == newValue)
                                              .id;
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
              ));
            },
          ),
        ));
  }
}
