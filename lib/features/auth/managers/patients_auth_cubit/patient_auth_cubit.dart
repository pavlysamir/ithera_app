import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'patient_auth_state.dart';

class PatientAuthCubit extends Cubit<PatientAuthState> {
  PatientAuthCubit(
    this.authRepo,
  ) : super(PatientAuthInitial());
  AuthRepo authRepo;
  static PatientAuthCubit get(context) => BlocProvider.of(context);

  // void chooseItem(String item) => emit(PatientAuthState(item: item)); // choose item

  Future<void> cashedUserDataFirstScreen({
    required String userName,
    required String userEmail,
    required String userPhone,
    required int cityId,
    required int regionId,
    required int genderId,
  }) async {
    emit(CashedPatientRegisterUserDataLoading());
    CacheHelper.set(key: CacheConstants.userName, value: userName);
    CacheHelper.set(key: CacheConstants.userEmail, value: userEmail);
    CacheHelper.set(key: CacheConstants.userPhone, value: userPhone);
    CacheHelper.set(key: CacheConstants.cityId, value: cityId);
    CacheHelper.set(key: CacheConstants.regionId, value: regionId);
    CacheHelper.set(key: CacheConstants.gender, value: genderId);

    emit(CashedPatientRegisterUserDataSuccess());
  }

  patientSignUp() async {
    emit(PatientAuthLoading());

    final result = await authRepo.patientRegister(
      email: CacheHelper.getString(key: CacheConstants.userEmail) ?? '',
      phoneNumber: CacheHelper.getString(key: CacheConstants.userPhone) ?? '',
      userName: CacheHelper.getString(key: CacheConstants.userName) ?? '',
      password: CacheHelper.getString(key: CacheConstants.password) ?? '',
      cityId: CacheHelper.getInt(key: CacheConstants.cityId) ?? 0,
      regionId: CacheHelper.getInt(key: CacheConstants.regionId) ?? 0,
      genderId: CacheHelper.getInt(key: CacheConstants.gender) ?? 0,
    );

    result.fold(
      (failure) => emit(PatientAuthError(failure)),
      (success) => emit(PatientAuthSuccess('success')),
    );
  }
}
