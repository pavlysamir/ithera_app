import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/helpers/validation_handling.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_form_field.dart';
import 'package:ithera_app/core/widgets/custom_toggle_isMale.dart';
import 'package:ithera_app/core/widgets/cutom_button_large_dimmide.dart';
import 'package:ithera_app/features/auth/presentation/doctor_auth/widgets/custom_import_image_field.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/custom_normal_rich_text.dart';
import 'package:ithera_app/features/home/patient_home/data/models/book_session_request_model.dart';
import 'package:ithera_app/features/home/patient_home/data/models/doctors_model.dart';
import 'package:ithera_app/features/home/patient_home/managers/booking_cubit/cubit/booking_cubit.dart';
import 'package:ithera_app/features/home/patient_home/presentation/widgets/custom_appountment_container.dart';
import 'package:ithera_app/features/home/patient_home/presentation/widgets/custom_check_box.dart';
import 'package:ithera_app/features/home/patient_home/presentation/widgets/custom_description_field.dart';

class BookNowScreen extends StatefulWidget {
  const BookNowScreen(
      {super.key, required this.schedule, required this.doctorId});
  final DoctorRegionSchedule schedule;
  final int doctorId;
  @override
  State<BookNowScreen> createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  bool isChecked = false;
  File? patientReport;
  File? xRayImage;
  File? idCardImage;

  String? xRayImageName;
  String? patientReportName;
  String? idCardImageName;
  bool? isMale;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressDescriptionController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var bookFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    descriptionController.dispose();
    addressDescriptionController.dispose();
    nameController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is SuccessfulBookSession) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.textGreen,
                content: Text(state.successMessage),
              ),
            );
          } else if (state is FailBookSession) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: AppColors.error100,
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<BookingCubit>(context);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Form(
              key: bookFormKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppountmentContainer(
                      city: widget.schedule.regionName,
                      days: widget.schedule.days.join(", "),
                      timeRange:
                          'من ${widget.schedule.schedules[0].startTime} إلي ${widget.schedule.schedules[0].endTime}',
                      startDate:
                          'بداية من ${widget.schedule.schedules[0].startDate.day}/${widget.schedule.schedules[0].startDate.month}/${widget.schedule.schedules[0].startDate.year}',
                    ),
                    const SizedBox(height: 25),
                    CustomCheckboxRow(
                      isChecked: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    isChecked ? isCheckWithTrue() : const SizedBox(),
                    const SizedBox(height: 25),
                    const CustomNormalRichText(
                      ischoosen: true,
                      firstText: 'تقارير الحالة أو تحويل الدكتور',
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomImportImageField(onTap: () {
                      BlocProvider.of<BookingCubit>(context)
                          .pickCameraImage()
                          .then((value) {
                        patientReport = cubit.file;
                        patientReportName = cubit.fileName;
                      });
                    }),
                    patientReportName != null
                        ? Padding(
                            padding: EdgeInsets.only(left: 8.w, top: 8.h),
                            child: Center(
                              child: Text(
                                patientReportName!,
                                style: AppTextStyles.font12Regular.copyWith(
                                    color: AppColors.primaryColor,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 25),
                    const CustomNormalRichText(
                      ischoosen: true,
                      firstText: 'أرفع صورة  الاشعة',
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomImportImageField(onTap: () {
                      BlocProvider.of<BookingCubit>(context)
                          .pickCameraImage()
                          .then((value) {
                        xRayImage = cubit.file;
                        xRayImageName = cubit.fileName;
                      });
                    }),
                    xRayImageName != null
                        ? Padding(
                            padding: EdgeInsets.only(left: 8.w, top: 8.h),
                            child: Center(
                              child: Text(
                                xRayImageName!,
                                style: AppTextStyles.font12Regular.copyWith(
                                    color: AppColors.primaryColor,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 25),
                    const CustomNormalRichText(
                      ischoosen: false,
                      firstText: 'وصف التاريخ المرضى والاعراض',
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomDescriptionFormField(
                      controller: descriptionController,
                      hintText: 'اكتب وصف الحالة',
                      textInputType: TextInputType.multiline,
                      validationMassage: (value) {
                        if (value.isEmpty) {
                          return 'يرجى إدخال وصف الحالة';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    const CustomNormalRichText(
                      ischoosen: false,
                      firstText: 'عنوانك بالتفصيل',
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomDescriptionFormField(
                      controller: addressDescriptionController,
                      hintText: 'اكتب عنوانك بالتفصيل',
                      textInputType: TextInputType.multiline,
                      validationMassage: (value) {
                        if (value.isEmpty) {
                          return 'يرجى إدخال عنوان الحالة';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: addressDescriptionController,
                      builder: (context, addressVaue, _) {
                        return ValueListenableBuilder<TextEditingValue>(
                          valueListenable: descriptionController,
                          builder: (context, descriptionValue, _) {
                            bool isEnabled = addressVaue.text.isNotEmpty &&
                                descriptionValue.text.isNotEmpty;
                            return isEnabled
                                ? state is BookingLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                        ),
                                      )
                                    : CustomButtonLarge(
                                        text: 'تأكيد الحجز',
                                        textColor: Colors.white,
                                        function: () {
                                          if (bookFormKey.currentState!
                                              .validate()) {
                                            isChecked == false
                                                ?

                                                //if patient book for himself
                                                BlocProvider.of<BookingCubit>(
                                                        context)
                                                    .bookSession(
                                                    request: BookingRequest(
                                                      patientId:
                                                          CacheHelper.getInt(
                                                              key:
                                                                  CacheConstants
                                                                      .userId)!,
                                                      cardId: widget
                                                          .schedule.cardId,
                                                      doctorId: widget.doctorId,
                                                      address: addressVaue.text,
                                                      diagnosiss:
                                                          descriptionValue.text,
                                                    ),
                                                  )
                                                    .then((_) {
                                                    setState(() {
                                                      // Clear all form fields
                                                      descriptionController
                                                          .clear();
                                                      addressDescriptionController
                                                          .clear();
                                                      nameController.clear();
                                                      phoneController.clear();

                                                      // Reset selections
                                                      isChecked = false;
                                                      isMale = null;

                                                      // Clear uploaded files and names
                                                      xRayImage = null;
                                                      patientReport = null;
                                                      xRayImageName = null;
                                                      patientReportName = null;
                                                    });
                                                  })
                                                :

//if patient book for another person
                                                BlocProvider.of<BookingCubit>(
                                                        context)
                                                    .bookSession(
                                                    request: BookingRequest(
                                                      patientId:
                                                          CacheHelper.getInt(
                                                              key:
                                                                  CacheConstants
                                                                      .userId)!,
                                                      cardId: widget
                                                          .schedule.cardId,
                                                      doctorId: widget.doctorId,
                                                      address: addressVaue.text,
                                                      diagnosiss:
                                                          descriptionValue.text,
                                                      anotherPatient: true,
                                                      patientName:
                                                          nameController.text,
                                                      anotherPatientPhoneNumber:
                                                          phoneController.text,
                                                      gender: isMale! ? 1 : 2,
                                                    ),
                                                  )
                                                    .then((_) {
                                                    setState(() {
                                                      // Clear all form fields
                                                      descriptionController
                                                          .clear();
                                                      addressDescriptionController
                                                          .clear();
                                                      nameController.clear();
                                                      phoneController.clear();

                                                      // Reset selections
                                                      isChecked = false;
                                                      isMale = null;

                                                      // Clear uploaded files and names
                                                      xRayImage = null;
                                                      patientReport = null;
                                                      xRayImageName = null;
                                                      patientReportName = null;
                                                    });
                                                  });
                                          }
                                        },
                                        color: AppColors.primaryColor,
                                      )
                                : const CustomButtonLargeDimmed(
                                    text: 'تأكيد الحجز');
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Column isCheckWithTrue() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
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
        const SizedBox(height: 25),
        CustomToggleisMale(
          isMale: isMale,
          onMaleTap: () {
            setState(() {
              if (isMale == null) {
                isMale = true;
              } else {
                isMale = null;
              }

              if (kDebugMode) {
                print(isMale);
              }
            });
          },
          onFemaleTap: () {
            setState(() {
              if (isMale == null) {
                isMale = false;
              } else {
                isMale = null;
              }
              if (kDebugMode) {
                print(isMale);
              }
            });
          },
        ),
        isMale == false
            ? BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) {
                  var cubit = BlocProvider.of<BookingCubit>(context);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      const CustomNormalRichText(
                        ischoosen: false,
                        firstText: 'صورة بطاقة الحالة ',
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      CustomImportImageField(onTap: () {
                        BlocProvider.of<BookingCubit>(context)
                            .pickCameraImage()
                            .then((value) {
                          idCardImage = cubit.file;
                          idCardImageName = cubit.fileName;
                        });
                      }),
                      idCardImageName != null
                          ? Padding(
                              padding: EdgeInsets.only(left: 8.w, top: 8.h),
                              child: Center(
                                child: Text(
                                  idCardImageName!,
                                  style: AppTextStyles.font12Regular.copyWith(
                                      color: AppColors.primaryColor,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  );
                },
              )
            : const SizedBox(),
      ],
    );
  }
}
