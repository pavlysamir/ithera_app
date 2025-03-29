import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/features/booking/patients_booking/presentations/patient_booking_screen.dart';
import 'package:ithera_app/features/home/patient_home/presentation/screens/patient_home_screen.dart';
import 'package:ithera_app/features/settings/patients_settings/presentation/screens/patient_settings_screen.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;
  List patintScreens = [
    const PatientSettingsScreen(),
    const PatientHomeScreen(),
    const PatientBookingScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;

    emit(HomeChaneNavBar());
  }
}
