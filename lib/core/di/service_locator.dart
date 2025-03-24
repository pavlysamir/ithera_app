import 'package:get_it/get_it.dart';
import 'package:ithera_app/features/auth/patient_auth/managers/cubit/patient_auth_cubit.dart';

final getIt = GetIt.instance;
void setUpServiceLocator() {
  getIt.registerSingleton<PatientAuthCubit>(PatientAuthCubit());
}
