import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/screens/doctor_booking_screen.dart';
import 'package:ithera_app/features/home/doctor_home/presentation/screens/doctor_home_screen.dart';
import 'package:ithera_app/features/home/patient_home/presentation/screens/patient_home_screen.dart';
import 'package:ithera_app/features/settings/doctors_settings/presentation/screens/doctor_settings_screen.dart';
import 'package:ithera_app/features/settings/patients_settings/presentation/screens/patient_settings_screen.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;
  List patintScreens = [
    const PatientSettingsScreen(),
    const PatientHomeScreen(),
    const DoctorBookingScreen(),
  ];

  List doctorScreens = [
    const DoctorSettingsScreen(),
    const DoctorHomeScreen(),
    const DoctorBookingScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;

    emit(HomeChaneNavBar());
  }
}
