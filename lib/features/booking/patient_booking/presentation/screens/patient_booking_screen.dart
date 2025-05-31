import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_listview_shimmer.dart';
import 'package:ithera_app/features/booking/patient_booking/data/models/patient_booking_model.dart';
import 'package:ithera_app/features/booking/patient_booking/managers/cubit/patient_booking_cubit.dart';
import 'package:ithera_app/features/booking/patient_booking/presentation/screens/no_booking_screen.dart';
import 'package:ithera_app/features/booking/patient_booking/presentation/widgets/custom_active_booking_container.dart';
import 'package:ithera_app/features/booking/patient_booking/presentation/widgets/custom_listview_last_patient_booking.dart';

class PatientBookingScreen extends StatefulWidget {
  const PatientBookingScreen({super.key});

  @override
  State<PatientBookingScreen> createState() => _PatientBookingScreenState();
}

class _PatientBookingScreenState extends State<PatientBookingScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<PatientBookingCubit>().initializeIfNeeded();
  }

  Future<void> _onRefresh() async {
    await context.read<PatientBookingCubit>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          color: AppColors.primaryColor,
          backgroundColor: Colors.white,
          child: BlocConsumer<PatientBookingCubit, PatientBookingState>(
            listener: (context, state) {
              if (state is PatientBookingError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.error100,
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              List<PatientBookingModel> activeBookings = [];
              List<PatientBookingModel> lastBookings = [];
              bool isInitialLoading = state is PatientBookingInitial;
              bool isLoading = state is PatientBookingLoading;

              // استخراج البيانات من جميع الحالات
              switch (state.runtimeType) {
                case PatientBookingLoading:
                  final loadingState = state as PatientBookingLoading;
                  activeBookings = loadingState.activeBookings;
                  lastBookings = loadingState.lastBookings;
                  break;
                case PatientBookingLoaded:
                  final loadedState = state as PatientBookingLoaded;
                  activeBookings = loadedState.activeBookings;
                  lastBookings = loadedState.lastBookings;
                  break;
                case PatientBookingError:
                  final errorState = state as PatientBookingError;
                  activeBookings = errorState.activeBookings;
                  lastBookings = errorState.lastBookings;
                  break;
              }

              // تحقق من عدم وجود بيانات نهائياً فقط بعد انتهاء التحميل
              bool hasNoData = activeBookings.isEmpty && lastBookings.isEmpty;
              bool isDataFinal =
                  state is PatientBookingLoaded || state is PatientBookingError;

              if (isDataFinal && hasNoData) {
                return const NoBookingScreen();
              }

              // عرض loading indicator فقط في البداية
              if (isInitialLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      _buildActiveBookingsSection(
                        activeBookings: activeBookings,
                        isLoading: isLoading && activeBookings.isEmpty,
                      ),
                      const SizedBox(height: 30),
                      _buildLastBookingsSection(
                        lastBookings: lastBookings,
                        isLoading: isLoading && lastBookings.isEmpty,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildActiveBookingsSection({
    required List<PatientBookingModel> activeBookings,
    required bool isLoading,
  }) {
    if (isLoading) {
      return const CustomItemDoctorShimmer();
    }

    if (activeBookings.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الحجوزات النشطة',
          style: AppTextStyles.font14Regular.copyWith(
            color: AppColors.blackLight,
          ),
        ),
        SizedBox(height: 2.h),
        const Divider(
          color: AppColors.grey100,
          thickness: 1,
        ),
        SizedBox(height: 20.h),
        CustomActiveBookingContainer(
          activeBookings: activeBookings.first,
        ),
      ],
    );
  }

  Widget _buildLastBookingsSection({
    required List<PatientBookingModel> lastBookings,
    required bool isLoading,
  }) {
    if (isLoading) {
      return const CustomItemDoctorShimmer();
    }

    if (lastBookings.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الحجوزات السابقة',
          style: AppTextStyles.font14Regular.copyWith(
            color: AppColors.blackLight,
          ),
        ),
        SizedBox(height: 2.h),
        const Divider(
          color: AppColors.grey100,
          thickness: 1,
        ),
        SizedBox(height: 20.h),
        const LastPatinetBooking(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
