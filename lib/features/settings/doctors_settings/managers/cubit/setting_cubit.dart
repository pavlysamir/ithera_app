import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ithera_app/features/settings/doctors_settings/data/models/doctor_walled_data_model.dart';
import 'package:ithera_app/features/settings/doctors_settings/data/repo/settings_repo.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit(this._settingsRepo) : super(SettingInitial());
  final SettingsRepo _settingsRepo;

  static SettingCubit get(context) => BlocProvider.of(context);

  Future<void> getDoctorWalletDetails() async {
    emit(DataWalletLoading());
    final result = await _settingsRepo.getDoctorWalletDetails();
    result.fold(
      (error) => emit(DataWalletError(error)),
      (walletData) => emit(DataWalletLoaded(walletData)),
    );
  }

  Future<void> submitDoctorWalletRequest({
    required int amount,
    required int walletType,
    required String mobileNumber,
    required String transferFromNumber,
    required int type,
  }) async {
    emit(SubmetDataWalletLoading());
    final result = await _settingsRepo.submitDoctorWalletRequest(
      amount: amount,
      walletType: walletType,
      mobileNumber: mobileNumber,
      transferFromNumber: transferFromNumber,
      type: type,
    );
    result.fold((error) => emit(SubmetDataWalletError(error)),
        (walletData) => emit(SubmetDataWalletLoaded(walletData)));
  }

  String? base64BackImage;

  File? file;
  String? fileName;

  Future<void> pickCameraImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Read the image file
      final bytes = await File(image.path).readAsBytes();
      // Decode the image
      img.Image? originalImage = img.decodeImage(bytes);

      fileName = path.basename(image.path);

      if (originalImage != null) {
        // Resize the image to a smaller size (e.g., width 600 pixels)
        img.Image resizedImage = img.copyResize(originalImage, width: 600);

        // Compress the image (optional)
        List<int> compressedBytes = img.encodeJpg(resizedImage, quality: 30);

        base64BackImage = base64Encode(compressedBytes);

        file = File(image.path);
        if (kDebugMode) {
          print(file!.path);
        }

        // Emit success state
        emit(SuccessfulPickImage());
      } else {
        emit(FailPickImage());
      }
    } else {
      emit(FailPickImage());
    }
  }
}
