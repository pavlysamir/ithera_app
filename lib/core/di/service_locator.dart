import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ithera_app/core/api/dio_consumer.dart';
import 'package:ithera_app/features/add_files/data/repo/add_file_repo.dart';
import 'package:ithera_app/features/add_files/manager/cubit/add_files_cubit.dart';
import 'package:ithera_app/features/auth/data/repo/auth_repo.dart';
import 'package:ithera_app/features/auth/managers/doctor_auth_cubit/doctor_auth_cubit.dart';
import 'package:ithera_app/features/auth/managers/patients_auth_cubit/patient_auth_cubit.dart';
import 'package:ithera_app/features/get_baseLookUp/data/repo/base_look_repo.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_cubit.dart';
import 'package:ithera_app/features/home/doctor_home/data/repos/manage_schedules_booking_repo.dart';
import 'package:ithera_app/features/home/doctor_home/managers/cubit/doctor_manage_schedules_cubit.dart';
import 'package:ithera_app/features/home/patient_home/managers/booking_cubit/cubit/booking_cubit.dart';
import 'package:ithera_app/features/settings/patients_settings/managers/cubit/seetings_cubit.dart';

final getIt = GetIt.instance;
void setUpServiceLocator() {
  getIt.registerSingleton<DioConsumer>(DioConsumer(
    dio: Dio(),
  ));

  getIt.registerSingleton<BaseLookRepo>(BaseLookRepo(
    api: getIt.get<DioConsumer>(),
  ));

  getIt.registerSingleton<AuthRepo>(AuthRepo(
    api: getIt.get<DioConsumer>(),
  ));

  getIt.registerSingleton<AddFileRepo>(AddFileRepo(
    api: getIt.get<DioConsumer>(),
  ));

  getIt
      .registerSingleton<ManageSchedulesBookingRepo>(ManageSchedulesBookingRepo(
    getIt.get<DioConsumer>(),
  ));
  getIt.registerFactory<PatientAuthCubit>((() => PatientAuthCubit(
        getIt(),
      )));
  getIt.registerFactory<DoctorAuthCubit>((() => DoctorAuthCubit(getIt())));
  getIt.registerFactory<BadeLookUpCubit>((() => BadeLookUpCubit(
        baseLookRepo: getIt(),
      )));

  getIt.registerLazySingleton<BookingCubit>((() => BookingCubit()));
  getIt.registerFactory<SettingsCubit>((() => SettingsCubit()));
  getIt.registerFactory<AddFilesCubit>((() => AddFilesCubit(getIt())));
  getIt.registerFactory<DoctorManageSchedulesCubit>(
      (() => DoctorManageSchedulesCubit(getIt())));
}
