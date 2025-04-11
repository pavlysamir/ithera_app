import 'package:get_it/get_it.dart';
import 'package:ithera_app/features/auth/managers/doctor_auth_cubit/doctor_auth_cubit.dart';
import 'package:ithera_app/features/auth/managers/patients_auth_cubit/patient_auth_cubit.dart';

final getIt = GetIt.instance;
void setUpServiceLocator() {
  getIt.registerFactory<PatientAuthCubit>((() => PatientAuthCubit()));
  getIt.registerFactory<DoctorAuthCubit>((() => DoctorAuthCubit()));
}
