import 'package:bloc/bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:meta/meta.dart';

part 'patient_auth_state.dart';

class PatientAuthCubit extends Cubit<PatientAuthState> {
  PatientAuthCubit() : super(PatientAuthInitial());

  // void chooseItem(String item) => emit(PatientAuthState(item: item)); // choose item

  Future<void> cashedUserDataFirstScreen({
    required String userName,
    required String userEmail,
    required String userPhone,
    required String cityId,
    required String regionId,
    required String genderId,
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
}
