import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/core/di/service_locator.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/screens/doctor_booking_screen.dart';
import 'package:ithera_app/features/booking/patient_booking/presentation/screens/patient_booking_screen.dart';
import 'package:ithera_app/features/home/doctor_home/managers/cubit/doctor_manage_schedules_cubit.dart';
import 'package:ithera_app/features/home/doctor_home/presentation/screens/doctor_home_screen.dart';
import 'package:ithera_app/features/home/patient_home/presentation/screens/patient_home_screen.dart';
import 'package:ithera_app/features/settings/doctors_settings/presentation/screens/doctor_settings_screen.dart';
import 'package:ithera_app/features/settings/patients_settings/managers/cubit/seetings_cubit.dart';
import 'package:ithera_app/features/settings/patients_settings/presentation/screens/patient_settings_screen.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;
  List patintScreens = [
    BlocProvider(
      create: (context) => getIt<SettingsCubit>(),
      child: const PatientSettingsScreen(),
    ),
    const PatientHomeScreen(),
    const PatientBookingScreen(),
  ];

  List doctorScreens = [
    BlocProvider(
      create: (context) => getIt<SettingsCubit>(),
      child: const DoctorSettingsScreen(),
    ),
    BlocProvider(
      create: (context) =>
          getIt<DoctorManageSchedulesCubit>()..getManageSchedules(),
      child: const DoctorHomeScreen(),
    ),
    const DoctorBookingScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;

    emit(HomeChaneNavBar());
  }
}
