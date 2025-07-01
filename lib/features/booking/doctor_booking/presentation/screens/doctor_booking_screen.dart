import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/widgets/custom_listview_shimmer.dart';
import 'package:ithera_app/features/booking/doctor_booking/data/models/doctor_booking_model.dart';
import 'package:ithera_app/features/booking/doctor_booking/managers/cubit/doctor_booking_cubit.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/widgets/custom_booking_listview.dart';
import 'package:ithera_app/features/booking/patient_booking/presentation/screens/no_booking_screen.dart';

class DoctorBookingScreen extends StatefulWidget {
  const DoctorBookingScreen({super.key});

  @override
  State<DoctorBookingScreen> createState() => _DoctorBookingScreenState();
}

class _DoctorBookingScreenState extends State<DoctorBookingScreen>
    with AutomaticKeepAliveClientMixin {
  int selectedIndex = 0;

  final List<String> tabs = [
    'حجوزاتك الحالية',
    'حجوزات سابقة',
    'حجوزات التي لم تكتمل',
  ];
  @override
  void initState() {
    super.initState();
    context.read<DoctorBookingCubit>().initializeIfNeeded();
  }

  Future<void> _onRefresh() async {
    await context.read<DoctorBookingCubit>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<DoctorBookingCubit, DoctorBookingState>(
          listener: (context, state) {
            if (state is DoctorBookingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.error100,
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            List<DoctorBookingModel> activeBookings = [];
            List<DoctorBookingModel> lastBookings = [];
            List<DoctorBookingModel> unCompletedBookings = [];
            bool isInitialLoading = state is DoctorBookingInitial;
            bool isLoading = state is DoctorBookingLoading;

            // استخراج البيانات من جميع الحالات
            switch (state.runtimeType) {
              case DoctorBookingLoading:
                final loadingState = state as DoctorBookingLoading;
                activeBookings = loadingState.activeBookings;
                lastBookings = loadingState.lastBookings;
                unCompletedBookings = loadingState.unCompletedBookings;

                break;
              case DoctorBookingLoaded:
                final loadedState = state as DoctorBookingLoaded;
                activeBookings = loadedState.activeBookings;
                lastBookings = loadedState.lastBookings;
                unCompletedBookings = loadedState.unCompletedBookings;
                break;
              case DoctorBookingError:
                final errorState = state as DoctorBookingError;
                activeBookings = errorState.activeBookings;
                lastBookings = errorState.lastBookings;
                unCompletedBookings = errorState.unCompletedBookings;
                break;
            }

            // تحقق من عدم وجود بيانات نهائياً فقط بعد انتهاء التحميل
            bool hasNoData = activeBookings.isEmpty &&
                lastBookings.isEmpty &&
                unCompletedBookings.isEmpty;
            bool isDataFinal =
                state is DoctorBookingLoaded || state is DoctorBookingError;

            if (isDataFinal && hasNoData) {
              return const NoBookingScreen();
            }

            // عرض loading indicator فقط في البداية
            if (isInitialLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return RefreshIndicator(
              onRefresh: _onRefresh,
              color: AppColors.primaryColor,
              child: Column(
                children: [
                  const SizedBox(height: 37),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: List.generate(tabs.length, (index) {
                        final isSelected = index == selectedIndex;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.white,
                              side: const BorderSide(
                                  color: AppColors.primaryColor, width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                            ),
                            child: Text(
                              tabs[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  isLoading
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (_, __) {
                                return const CustomItemDoctorShimmer();
                              }),
                        )
                      : Expanded(
                          child: CustomBookingDoctorListView(
                            bookings: selectedIndex == 0
                                ? activeBookings
                                : selectedIndex == 1
                                    ? lastBookings
                                    : unCompletedBookings,
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
