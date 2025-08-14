import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/helpers/validation_handling.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_drop_down_menu.dart';
import 'package:ithera_app/core/widgets/custom_form_field.dart';
import 'package:ithera_app/core/widgets/custom_multi_select_dropdown.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';
import 'package:ithera_app/core/widgets/custom_toggle_isMale.dart';
import 'package:ithera_app/core/widgets/cutom_button_large_dimmide.dart';
import 'package:ithera_app/features/add_files/manager/cubit/add_files_cubit.dart';
import 'package:ithera_app/features/auth/presentation/doctor_auth/widgets/circular_profile_img.dart';
import 'package:ithera_app/features/auth/presentation/doctor_auth/widgets/custom_import_image_field.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/custom_normal_rich_text.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_cubit.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_state.dart';
import 'package:ithera_app/features/settings/doctors_settings/managers/cubit/setting_cubit.dart';

class DoctorEditProfile extends StatefulWidget {
  const DoctorEditProfile({super.key});

  @override
  State<DoctorEditProfile> createState() => _DoctorEditProfileState();
}

class _DoctorEditProfileState extends State<DoctorEditProfile> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController anotherPhoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  var formDoctorEditProfileScreenKey = GlobalKey<FormState>();

  String? selectSpicification;
  String? selectedValueRegion;
  File? profileImagePath;
  File? karnehImagePath;
  String? karnehImageName;
  int? cityId;

  List<String> selectedItemsList = [];
  List<int> selectedItemsListIds = [];

  bool? isMale;
  bool _isFormInitialized = false;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    anotherPhoneController.dispose();
    // Dispose of the profile image and karneh image if they are not null
    if (profileImagePath != null) {
      profileImagePath!.deleteSync();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final settingState = context.read<SettingCubit>().state;
    if (!_isFormInitialized && settingState is DoctorDataLoaded) {
      final data = settingState.doctorData;

      nameController.text = data.doctorName;
      phoneController.text = data.phoneNumber ?? ''; // عدل حسب المتاح
      anotherPhoneController.text = data.anotherMobileNumber ?? '';
      emailController.text = data.email ?? '';
      cityId = data.cityId;
      isMale = data.gender;
      selectedItemsList =
          data.specializationFields.map((e) => e.nameAr).toList();
      selectedItemsListIds =
          data.specializationFields.map((e) => e.id).toList();

      _isFormInitialized = true;
    }
  }

  @override
  void initState() {
    super.initState();

    context.read<SettingCubit>().getDoctorData();

    // // Add listeners to text controllers
    // nameController.addListener(() {
    //   setState(() {});
    // });
    // phoneController.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: BlocConsumer<SettingCubit, SettingState>(
          listener: (context, state) {
            if (state is DoctorDataLoaded) {
              final data = state.doctorData;

              nameController.text = data.doctorName;
              phoneController.text = data.phoneNumber ?? '';
              emailController.text = data.email ?? '';
              anotherPhoneController.text = data.anotherMobileNumber ?? '';
              cityId = data.cityId;
              isMale = data.gender;
              selectedItemsList =
                  data.specializationFields.map((e) => e.nameAr).toList();
              selectedItemsListIds =
                  data.specializationFields.map((e) => e.id).toList();
            }

            if (state is SuccessfulPickImage) {
              profileImagePath = state.imageFile;
            }

            if (state is ImageCleared) {
              profileImagePath = null;
            }

            if (state is UpdateDoctorDataLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is DoctorDataLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }

            if (state is DoctorDataError) {
              return const Center(child: Text("فشل في تحميل البيانات"));
            }

            return buildFormBody(context, state);
          },
        ),
      ),
    );
  }

  Widget buildFormBody(BuildContext context, SettingState state) {
    return SingleChildScrollView(
      child: Form(
        key: formDoctorEditProfileScreenKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
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
                child: Text('تعديل حسابك', style: AppTextStyles.font28Medium),
              ),
              SizedBox(height: 24.h),
              CircularProfileImage(
                file: profileImagePath,
                closeFunction: () {
                  context.read<SettingCubit>().clearProfileImage();
                },
                function: () {
                  // Pick image
                  context.read<SettingCubit>().pickCameraImage();
                },
              ),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.center,
                child: Text('برجاء رفع صورة بالبالطو الابيض...',
                    style: AppTextStyles.font10Regular),
              ),
              SizedBox(height: 24.h),
              const CustomNormalRichText(ischoosen: false, firstText: 'الأسم'),
              SizedBox(height: 18.h),
              CustomFormField(
                  controller: nameController,
                  validate: conditionOfValidationName,
                  hintText: 'الأسم ثنائي',
                  textInputType: TextInputType.text),
              SizedBox(height: 32.h),
              const CustomNormalRichText(
                  ischoosen: false, firstText: 'رقم الموبيل'),
              SizedBox(height: 18.h),
              CustomFormField(
                  controller: phoneController,
                  validate: conditionOfValidationPhone,
                  hintText: '01000000000',
                  textInputType: TextInputType.phone),
              SizedBox(height: 32.h),
              const CustomNormalRichText(
                  ischoosen: true, firstText: 'رقم موبايل آخر'),
              SizedBox(height: 18.h),
              CustomFormField(
                  controller: anotherPhoneController,
                  hintText: '01000000000',
                  textInputType: TextInputType.phone),
              SizedBox(height: 32.h),
              const CustomNormalRichText(ischoosen: true, firstText: 'إيميل'),
              SizedBox(height: 18.h),
              CustomFormField(
                  controller: emailController,
                  hintText: 'name@gmail.com',
                  textInputType: TextInputType.emailAddress),
              SizedBox(height: 32.h),
              const CustomNormalRichText(
                  ischoosen: false, firstText: 'المحافظة'),
              SizedBox(height: 18.h),
              BlocBuilder<BadeLookUpCubit, BadeLookUpState>(
                builder: (context, state) {
                  return CustomDropDownMenu(
                    isLoading: state.citiesStatus == LookupStatus.loading,
                    items: state.cities?.map((e) => e.nameAr).toList() ?? [],
                    initialValue: state.cities
                        ?.firstWhere(
                          (e) => e.id == cityId,
                          orElse: () => state.cities!.first,
                        )
                        .nameAr,
                    onChange: (newValue) {
                      setState(() {
                        selectedValueRegion = newValue;
                        cityId = state.cities!
                            .firstWhere((e) => e.nameAr == newValue)
                            .id;
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 32.h),
              const CustomNormalRichText(ischoosen: false, firstText: 'التخصص'),
              SizedBox(height: 18.h),
              BlocBuilder<BadeLookUpCubit, BadeLookUpState>(
                builder: (context, state) {
                  return CustomMultiSelectDropDown(
                    items:
                        state.specialties?.map((e) => e.nameAr).toList() ?? [],
                    isLoading: state.specialtiesStatus == LookupStatus.loading,
                    selectedItems: selectedItemsList,
                    onSelectionChanged: (newSelected) {
                      setState(() {
                        selectedItemsList = newSelected;
                        selectedItemsListIds.clear();
                        selectedItemsListIds.addAll(
                          newSelected.map((e) => state.specialties!
                              .firstWhere((element) => element.nameAr == e)
                              .id),
                        );
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 32.h),
              const CustomNormalRichText(
                  ischoosen: false, firstText: 'صورة كارنيه النقابة'),
              SizedBox(height: 18.h),
              CustomImportImageField(onTap: () {
                // Pick karneh image
              }),
              if (karnehImageName != null)
                Padding(
                  padding: EdgeInsets.only(left: 8.w, top: 8.h),
                  child: Center(
                    child: Text(
                      karnehImageName!,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 32.h),
              CustomToggleisMale(
                isMale: isMale,
                onMaleTap: () {
                  setState(() {
                    isMale = isMale == true ? null : true;
                  });
                },
                onFemaleTap: () {
                  setState(() {
                    isMale = isMale == false ? null : false;
                  });
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              nameController.text.isNotEmpty &&
                      phoneController.text.isNotEmpty &&
                      selectedItemsList.isNotEmpty &&
                      selectedValueRegion != null &&
                      isMale != null
                  //||profileImagePath == null
                  //|| karnehImagePath == null
                  ? const CustomButtonLargeDimmed(text: 'حفظ')
                  : state is UpdateDoctorDataLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : BlocConsumer<AddFilesCubit, AddFilesState>(
                          listener: (context, state) {
                            if (state is AddFileSuccess) {
                              context
                                  .read<AddFilesCubit>()
                                  .getFile(fileId: 3, roleId: 1);
                            }
                            if (state is AddFileFaluir) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      'حدث خطأ اتناء تجميل صوره البروفايل او الكانيه'),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return CustomButtonLarge(
                              text: 'حفظ',
                              textColor: AppColors.white,
                              color: AppColors.primaryColor,
                              function: () {
                                if (formDoctorEditProfileScreenKey.currentState!
                                    .validate()) {
                                  final body = {
                                    "email": emailController.text,
                                    "userName": nameController.text,
                                    "phoneNumber": phoneController.text,
                                    "anotherMobileNumber":
                                        anotherPhoneController.text,
                                    "cityId": cityId!,
                                    "regionId": 0,
                                    "specializationFieldId":
                                        selectedItemsListIds.isNotEmpty
                                            ? selectedItemsListIds.first
                                            : 0,
                                    "gender": isMale! ? 1 : 2,
                                    "description": "",
                                  };

                                  // Call update API
                                  context
                                      .read<SettingCubit>()
                                      .updateDoctorData(body: body);

                                  if (profileImagePath != null) {
                                    context.read<AddFilesCubit>().addFile(
                                      rileId: 1,
                                      files: [profileImagePath!],
                                      fileType: ['3'],
                                    );
                                  }
                                }
                              },
                            );
                          },
                        ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
