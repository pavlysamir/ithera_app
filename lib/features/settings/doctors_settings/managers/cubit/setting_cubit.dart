import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ithera_app/features/settings/doctors_settings/data/models/doctor_walled_data_model.dart';
import 'package:ithera_app/features/settings/doctors_settings/data/repo/settings_repo.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit(this._settingsRepo) : super(SettingInitial());
  final SettingsRepo _settingsRepo;

  Future<void> getDoctorWalletDetails() async {
    emit(DataWalletLoading());
    final result = await _settingsRepo.getDoctorWalletDetails();
    result.fold(
      (error) => emit(DataWalletError(error)),
      (walletData) => emit(DataWalletLoaded(walletData)),
    );
  }
}
