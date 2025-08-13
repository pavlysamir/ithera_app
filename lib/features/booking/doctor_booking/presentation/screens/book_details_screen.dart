import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/di/service_locator.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/pop_up_dialog.dart';
import 'package:ithera_app/features/booking/doctor_booking/data/models/doctor_booking_model.dart';
import 'package:ithera_app/features/booking/doctor_booking/managers/cubit/doctor_booking_cubit.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/widgets/book_item_details.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/widgets/seesions_listview.dart';
import 'package:loader_overlay/loader_overlay.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({
    super.key,
    required this.booking,
  });
  final DoctorBookingModel booking;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        title: Text('الحجوزات',
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.black,
            )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<DoctorBookingCubit>(),
        child: BlocConsumer<DoctorBookingCubit, DoctorBookingState>(
          listener: (context, state) {
            if (state is ManageBookingDoctorLoaded) {
              context.loaderOverlay.hide();
              // Navigate back or show success message
              Navigator.pop(context);
            }
            if (state is ManageBookingDoctorError) {
              context.loaderOverlay.hide();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.error100,
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            return LoaderOverlay(
              useDefaultLoading: false,
              overlayColor: Colors.transparent,
              overlayWidgetBuilder: (_) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 2.5,
                    sigmaY: 2.5,
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 3,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DoctorBookItemDetails(booking: booking),
                    const SizedBox(height: 20),
                    Text(
                      'متابعة الجلسات',
                      style: AppTextStyles.font16Regular,
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    Expanded(
                        child: SeesionsList(
                      activeBookings: booking.sessions,
                    )),
                    const SizedBox(height: 10),
                    CustomButtonLarge(
                        text: 'الغاء الحجز نهائيا',
                        color: AppColors.primaryColor,
                        function: () {
                          _showCancelBookingDialog(context);
                        }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showCancelBookingDialog(BuildContext context) {
    final cubit = context.read<DoctorBookingCubit>();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => BlocProvider.value(
        value: cubit,
        child: PopUpDialog(
          function2: () {
            Navigator.pop(dialogContext);
            context.loaderOverlay.show();
            cubit.manageBookingStatus(
              bookingId: booking.id,
              status: 5,
            );
          },
          function: () {
            Navigator.pop(dialogContext);
          },
          title: 'هل تريد بالتأكيد الغاء هذا الحجز بالكامل ؟',
          img: AssetsData.deleteAccount,
          subTitle: '',
          colorButton1: AppColors.primaryColor,
          colorButton2: AppColors.white,
          textColortcolor1: Colors.white,
          textColortcolor2: AppColors.primaryColor,
          context: dialogContext,
        ),
      ),
    );
  }
}
