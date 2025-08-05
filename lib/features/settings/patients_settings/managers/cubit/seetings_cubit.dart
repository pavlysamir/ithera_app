import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/features/settings/doctors_settings/data/models/patient_data_model.dart';
import 'package:ithera_app/features/settings/doctors_settings/data/repo/settings_repo.dart';
import 'package:meta/meta.dart';

part 'seetings_state.dart';

class SettingsCubit extends Cubit<SeetingsState> {
  SettingsCubit(this._settingsRepo) : super(SeetingsInitial());
  static SettingsCubit get(context) => BlocProvider.of(context);
  final SettingsRepo _settingsRepo;

  lgOut() async {
    await CacheHelper.delete(
      key: CacheConstants.userId,
    );
    await CacheHelper.deleteSecureData(key: CacheConstants.token);
    ();
    emit(SignOutSuccess());
  }

  Future<void> getPatientData() async {
    emit(PatientDataLoading());
    final result = await _settingsRepo.getPatientrData();
    result.fold(
      (error) => emit(PatientDataError(error)),
      (patientData) => emit(PatientDataLoaded(patientData)),
    );
  }
}
