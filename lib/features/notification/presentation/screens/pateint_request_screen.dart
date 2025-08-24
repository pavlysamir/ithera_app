import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/helpers/validation_handling.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_button_small.dart';
import 'package:ithera_app/core/widgets/custom_form_field.dart';
import 'package:ithera_app/core/widgets/custom_toggle_isMale.dart';
import 'package:ithera_app/core/widgets/cutom_button_large_dimmide.dart';
import 'package:ithera_app/features/auth/presentation/doctor_auth/widgets/custom_import_image_field.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/custom_normal_rich_text.dart';
import 'package:ithera_app/features/home/patient_home/managers/booking_cubit/cubit/booking_cubit.dart';
import 'package:ithera_app/features/home/patient_home/presentation/widgets/custom_appountment_container.dart';
import 'package:ithera_app/features/home/patient_home/presentation/widgets/custom_check_box.dart';
import 'package:ithera_app/features/home/patient_home/presentation/widgets/custom_description_field.dart';
import 'package:ithera_app/features/notification/data/models/booking_details_model.dart';
import 'package:ithera_app/features/notification/managers/cubit/notifications_cubit.dart';
import 'package:ithera_app/features/notification/presentation/widgets/custom_book_details_container.dart';

class PateintRequestScreen extends StatefulWidget {
  const PateintRequestScreen({super.key, required this.bookingId});

  final int bookingId;
  @override
  State<PateintRequestScreen> createState() => _PateintRequestScreenState();
}

class _PateintRequestScreenState extends State<PateintRequestScreen> {
  bool isChecked = false;
  File? patientReport;
  File? xRayImage;
  File? idCardImage;

  String? xRayImageName;
  String? patientReportName;
  String? idCardImageName;
  bool? isMale;
  bool _isBookingInProgress = false;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressDescriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var bookFormKey = GlobalKey<FormState>();

  // Add a variable to store the booking data
  BookingDetailsData? bookingData;

  @override
  void initState() {
    super.initState();

    context
        .read<NotificationsCubit>()
        .getBookingDetails(bookingId: widget.bookingId);
  }

  @override
  void dispose() {
    descriptionController.dispose();
    addressDescriptionController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _clearFormData() {
    if (mounted) {
      setState(() {
        // Clear all form fields
        descriptionController.clear();
        addressDescriptionController.clear();
        nameController.clear();
        phoneController.clear();

        // Reset selections
        isChecked = false;
        isMale = null;

        // Clear uploaded files and names
        xRayImage = null;
        patientReport = null;
        idCardImage = null;
        xRayImageName = null;
        patientReportName = null;
        idCardImageName = null;
      });
    }
  }

  // Add method to populate form with booking data
  void _populateFormWithBookingData(BookingDetailsData data) {
    if (mounted) {
      setState(() {
        // Populate text fields
        descriptionController.text = data.diagnosisess;
        addressDescriptionController.text = data.address;

        // Set checkbox state based on anotherPatient flag
        isChecked = data.anotherPatient;

        // If booking is for another patient, populate those fields
        if (data.anotherPatient) {
          nameController.text = data.anotherPatientName ?? '';
          phoneController.text = data.anotherPatientPhoneNumber;

          // Set gender (1 = male, 2 = female)
          isMale = data.gender == 1 ? true : (data.gender == 2 ? false : null);
        }

        // Set image names if URLs exist (you might want to display these differently)
        if (data.reportURL != null) {
          patientReportName = 'تقرير المريض'; // Or extract filename from URL
        }

        if (data.xRayURL != null) {
          xRayImageName = 'صورة الأشعة'; // Or extract filename from URL
        }
      });
    }
  }

  // Future<void> _handleBookSession(bool isForAnotherPatient) async {
  //   if (_isBookingInProgress) return;

  //   setState(() {
  //     _isBookingInProgress = true;
  //   });

  //   try {
  //     final cubit = context.read<BookingCubit>();

  //     final request = BookingRequest(
  //       patientId: CacheHelper.getInt(key: CacheConstants.userId)!,
  //       cardId:
  //           bookingData!.regionSchedules.first.cardId, // Use data from booking
  //       doctorId: widget.doctorId,
  //       address: addressDescriptionController.text,
  //       diagnosiss: descriptionController.text,
  //       anotherPatient: isForAnotherPatient,
  //       patientName: isForAnotherPatient ? nameController.text : null,
  //       anotherPatientPhoneNumber:
  //           isForAnotherPatient ? phoneController.text : null,
  //       gender:
  //           isForAnotherPatient && isMale != null ? (isMale! ? 1 : 2) : null,
  //     );

  //     await cubit.bookSession(request: request).then((value) async {
  //       FirebaseApi.getfcmTokenFromDb(userId: widget.doctorId.toString())
  //           .then((fcmToken) {
  //         FirebaseApi.sendNotifications(
  //           body:
  //               'تم حجز موعد جديد من ${CacheHelper.getString(key: CacheConstants.userName)}',
  //           title: 'موعد جديد',
  //           fcmToken: fcmToken,
  //           userId: CacheHelper.getInt(key: CacheConstants.userId)!.toString(),
  //           type: 'booking',
  //         );
  //       });
  //     });
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         _isBookingInProgress = false;
  //       });
  //     }
  //   }
  // }

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
      body: BlocConsumer<NotificationsCubit, NotificationsState>(
        listener: (context, state) {
          if (state is GetBookingDetailsLoaded) {
            // Store booking data and populate form
            bookingData = state.bookingDetailsResponse;
            _populateFormWithBookingData(state.bookingDetailsResponse);
          } else if (state is GetBookingDetailsError) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: AppColors.error100,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is GetBookingDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is GetBookingDetailsLoaded) {
            // Use the stored booking data to render the appointment container
            final schedule = bookingData!.regionSchedules.first;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Form(
                key: bookFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomBookDetailsContainer(
                        patientMobile: bookingData!.mobileNumber,
                        patientName: bookingData!.patientName,
                        city: schedule.regionName,
                        days: schedule.days.join(", "),
                        timeRange:
                            'من ${schedule.schedules[0].startTime} إلي ${schedule.schedules[0].endTime}',
                        startDate:
                            'بداية من ${schedule.schedules[0].startDate.day}/${schedule.schedules[0].startDate.month}/${schedule.schedules[0].startDate.year}',
                      ),
                      const SizedBox(height: 25),
                      bookingData!.anotherPatient
                          ? CustomCheckboxRow(
                              isChecked: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value ?? false;
                                });
                              },
                            )
                          : const SizedBox(),
                      isChecked ? isCheckWithTrue() : const SizedBox(),
                      const SizedBox(height: 25),
                      const CustomNormalRichText(
                        ischoosen: true,
                        firstText: 'تقارير الحالة أو تحويل الدكتور',
                      ),
                      const SizedBox(height: 18),
                      CustomImportImageField(
                        onTap: () {
                          // _handleImagePick('patient_report');

                          bookingData!.reportURL != null
                              ? context
                                  .read<NotificationsCubit>()
                                  .downloadImage(
                                    context,
                                    bookingData!.reportURL!,
                                  )
                              : null;
                        },
                        isDownload: bookingData!.reportURL != null,
                      ),
                      if (patientReportName != null)
                        Padding(
                          padding: EdgeInsets.only(left: 8.w, top: 8.h),
                          child: Center(
                            child: Text(
                              patientReportName!,
                              style: AppTextStyles.font12Regular.copyWith(
                                  color: AppColors.primaryColor,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      const SizedBox(height: 25),
                      const CustomNormalRichText(
                        ischoosen: true,
                        firstText: 'أرفع صورة الاشعة',
                      ),
                      const SizedBox(height: 18),
                      CustomImportImageField(
                        onTap: () {
                          bookingData!.xRayURL != null
                              ? context
                                  .read<NotificationsCubit>()
                                  .downloadImage(
                                    context,
                                    bookingData!.xRayURL!,
                                  )
                              : null;
                          // _handleImagePick('xray');
                        },
                        isDownload: bookingData!.xRayURL != null,
                      ),
                      if (xRayImageName != null)
                        Padding(
                          padding: EdgeInsets.only(left: 8.w, top: 8.h),
                          child: Center(
                            child: Text(
                              xRayImageName!,
                              style: AppTextStyles.font12Regular.copyWith(
                                  color: AppColors.primaryColor,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      const SizedBox(height: 25),
                      const CustomNormalRichText(
                        ischoosen: false,
                        firstText: 'وصف التاريخ المرضى والاعراض',
                      ),
                      const SizedBox(height: 18),
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
                      const SizedBox(height: 18),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButtonSmall(
                            function: () {},
                            text: 'رفض',
                            color: AppColors.white,
                            borderColor: AppColors.primaryColor,
                            textColortcolor: AppColors.primaryColor,
                          ),
                          CustomButtonSmall(
                            function: () {},
                            text: 'قبول',
                            color: AppColors.primaryColor,
                            borderColor: AppColors.white,
                            textColortcolor: AppColors.white,
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('لا يوجد مواعيد متاحة'),
            );
          }
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
        SizedBox(height: 18.h),
        CustomFormField(
            controller: nameController,
            validate: conditionOfValidationName,
            hintText: 'الأسم ثنائي',
            textInputType: TextInputType.text),
        SizedBox(height: 32.h),
        const CustomNormalRichText(
          ischoosen: false,
          firstText: 'رقم الموبيل',
        ),
        SizedBox(height: 18.h),
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
              isMale = isMale == true ? null : true;
              if (kDebugMode) {
                print(isMale);
              }
            });
          },
          onFemaleTap: () {
            setState(() {
              isMale = isMale == false ? null : false;
              if (kDebugMode) {
                print(isMale);
              }
            });
          },
        ),
        if (isMale == false)
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  const CustomNormalRichText(
                    ischoosen: false,
                    firstText: 'صورة بطاقة الحالة ',
                  ),
                  const SizedBox(height: 18),
                  CustomImportImageField(onTap: () {
                    // _handleImagePick('id_card');
                  }),
                  if (idCardImageName != null)
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, top: 8.h),
                      child: Center(
                        child: Text(
                          idCardImageName!,
                          style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
      ],
    );
  }
}
