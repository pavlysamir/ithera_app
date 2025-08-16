import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ithera_app/features/home/doctor_home/data/models/doctor_schadules_model.dart';
import 'package:ithera_app/features/settings/doctors_settings/data/models/doctor_walled_data_model.dart';
import 'package:ithera_app/features/settings/doctors_settings/data/repo/settings_repo.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
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
    String? withdrawalReason,
  }) async {
    emit(SubmetDataWalletLoading());
    final result = await _settingsRepo.submitDoctorWalletRequest(
      amount: amount,
      type: type,
      walletType: walletType,
      mobileNumber: mobileNumber,
      transferFromNumber: transferFromNumber,
      withdrawalReason: withdrawalReason,
    );
    result.fold((error) => emit(SubmetDataWalletError(error)),
        (walletData) => emit(SubmetDataWalletLoaded(walletData)));
  }

  String? base64BackImage;

  File? file;
  String? fileName;

  void clearProfileImage() {
    file = null;
    base64BackImage = null;
    fileName = null;
    emit(ImageCleared()); // state جديد
  }

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
        emit(SuccessfulPickImage(
          file!,
        ));
      } else {
        emit(FailPickImage());
      }
    } else {
      emit(FailPickImage());
    }
  }


  Future<void> pickAndSavePDF() async {
    // 1. Pick the PDF file
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      final pickedFile = File(result.files.single.path!);

      // 2. Check file size
      final fileSizeInBytes = await pickedFile.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024); // Convert to MB

      if (fileSizeInMB > 2) {
        print('❌ الملف أكبر من 2 ميجا (${fileSizeInMB.toStringAsFixed(2)} MB)');
        // هنا تقدر تعرض SnackBar أو Emit Error لو بتستخدم Bloc
        return;
      }

      // 3. Get app directory to save the file
      final appDir = await getApplicationDocumentsDirectory();

      // 4. Create new file path
      fileName = path.basename(pickedFile.path);
      final newFilePath = path.join(appDir.path, fileName);

      // 5. Copy file to new location
      file = await pickedFile.copy(newFilePath);

      emit(SuccessfulPickCv());

      print('📄 PDF saved at: ${file!.path}');
    } else {
      print('❌ No file selected');
    }
  }

  Future<void> getDoctorData() async {
    emit(DoctorDataLoading());
    final result = await _settingsRepo.getDoctorData();
    result.fold(
      (error) => emit(DoctorDataError(error)),
      (doctorData) => emit(DoctorDataLoaded(doctorData.responseData)),
    );
  }

  Future<void> updateDoctorData({required Map<String, dynamic> body}) async {
    emit(UpdateDoctorDataLoading());
    final result = await _settingsRepo.updateDoctorData(body: body);
    result.fold(
      (error) => emit(UpdateDoctorDataError(error)),
      (message) => emit(UpdateDoctorDataLoaded(message)),
    );
  }
}
