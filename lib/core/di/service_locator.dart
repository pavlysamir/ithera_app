import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ithera_app/core/api/dio_consumer.dart';
import 'package:ithera_app/features/auth/managers/doctor_auth_cubit/doctor_auth_cubit.dart';
import 'package:ithera_app/features/auth/managers/patients_auth_cubit/patient_auth_cubit.dart';
import 'package:ithera_app/features/get_baseLookUp/data/repo/base_look_repo.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_cubit.dart';

final getIt = GetIt.instance;
void setUpServiceLocator() {
  getIt.registerSingleton<DioConsumer>(DioConsumer(
    dio: Dio(),
  ));

  getIt.registerSingleton<BaseLookRepo>(BaseLookRepo(
    api: getIt.get<DioConsumer>(),
  ));
  getIt.registerFactory<PatientAuthCubit>((() => PatientAuthCubit()));
  getIt.registerFactory<DoctorAuthCubit>((() => DoctorAuthCubit()));
  getIt.registerFactory<BadeLookUpCubit>((() => BadeLookUpCubit(
        baseLookRepo: getIt(),
      )));
}
