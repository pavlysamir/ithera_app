import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/core/di/service_locator.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/screens/doctor_booking_screen.dart';
import 'package:ithera_app/features/booking/patient_booking/presentation/screens/patient_booking_screen.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_cubit.dart';
import 'package:ithera_app/features/home/doctor_home/managers/cubit/doctor_manage_schedules_cubit.dart';
import 'package:ithera_app/features/home/doctor_home/presentation/screens/doctor_home_screen.dart';
import 'package:ithera_app/features/home/patient_home/managers/pagination_cubit/pagination_cubit.dart';
import 'package:ithera_app/features/home/patient_home/presentation/screens/patient_home_screen.dart';
import 'package:ithera_app/features/settings/doctors_settings/presentation/screens/doctor_settings_screen.dart';
import 'package:ithera_app/features/settings/patients_settings/managers/cubit/seetings_cubit.dart';
import 'package:ithera_app/features/settings/patients_settings/presentation/screens/patient_settings_screen.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;

  List<Widget> get patientScreens => [
        BlocProvider(
          create: (context) => getIt<SettingsCubit>(),
          child: const PatientSettingsScreen(),
        ),
        MultiBlocProvider(
          providers: [
            BlocProvider<PaginationCubit>(
              create: (context) => getIt<PaginationCubit>()..fetchItems(),
            ),
            BlocProvider<BadeLookUpCubit>(
              create: (context) => getIt<BadeLookUpCubit>()..getAllCities(),
            ),
          ],
          child: const PatientHomeScreen(),
        ),
        const PatientBookingScreen(),
      ];

  List<Widget> get doctorScreens => [
        BlocProvider(
          create: (context) => getIt<SettingsCubit>(),
          child: const DoctorSettingsScreen(),
        ),
        // Create fresh instance each time to avoid state conflicts
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
