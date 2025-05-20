import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

part 'doctor_auth_state.dart';

class DoctorAuthCubit extends Cubit<DoctorAuthState> {
  DoctorAuthCubit(
    this.authRepo,
  ) : super(DoctorAuthInitial());

  AuthRepo authRepo;
  static DoctorAuthCubit get(context) => BlocProvider.of(context);

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

  deleteImage() {
    file = null;
    base64BackImage = null;
    emit(DoctorAuthInitial());
  }

//   Future<void> pickAndSavePDF() async {
//   // 1. Pick the PDF file
//   final result = await FilePicker.platform.pickFiles(
//     type: FileType.custom,
//     allowedExtensions: ['pdf'],
//   );

//   if (result != null && result.files.single.path != null) {
//     final pickedFile = File(result.files.single.path!);

//     // 2. Check file size
//     final fileSizeInBytes = await pickedFile.length();
//     final fileSizeInMB = fileSizeInBytes / (1024 * 1024); // Convert to MB

//     if (fileSizeInMB > 2) {
//       print('❌ الملف أكبر من 2 ميجا (${fileSizeInMB.toStringAsFixed(2)} MB)');
//       // هنا تقدر تعرض SnackBar أو Emit Error لو بتستخدم Bloc
//       return;
//     }

//     // 3. Get app directory to save the file
//     final appDir = await getApplicationDocumentsDirectory();

//     // 4. Create new file path
//     final fileName = path.basename(pickedFile.path);
//     final newFilePath = path.join(appDir.path, fileName);

//     // 5. Copy file to new location
//     final savedFile = await pickedFile.copy(newFilePath);

//     print('📄 PDF saved at: ${savedFile.path}');
//   } else {
//     print('❌ No file selected');
//   }
// }

  Future<void> cashedDoctorDataFirstScreen({
    required String userName,
    required String userEmail,
    required String userPhone,
    required String anotherPhonreNumber,
    required String doctorImage,
    required String karnehImage,
    required List<int> specializationIds,
    required int regionId,
    required int genderId,
  }) async {
    emit(CashedDoctorRegisterUserDataLoading());
    CacheHelper.set(key: CacheConstants.userName, value: userName);
    CacheHelper.set(key: CacheConstants.userEmail, value: userEmail);
    CacheHelper.set(key: CacheConstants.userPhone, value: userPhone);
    CacheHelper.set(
        key: CacheConstants.anotherPhonreNumber, value: anotherPhonreNumber);
    CacheHelper.set(key: CacheConstants.doctorImage, value: doctorImage);
    CacheHelper.set(key: CacheConstants.karnehImage, value: karnehImage);
    CacheHelper.saveIntList(
        key: CacheConstants.spicializationNames, numbers: specializationIds);
    CacheHelper.set(key: CacheConstants.regionId, value: regionId);
    CacheHelper.set(key: CacheConstants.gender, value: genderId);

    emit(CashedDoctorRegisterUserDataSuccess());
  }

  Future<Either<String, String>> doctorSignUp() async {
    emit(DoctorAuthLoading());

    final result = await authRepo.doctorRegister(
      email: CacheHelper.getString(key: CacheConstants.userEmail) ?? '',
      phoneNumber: CacheHelper.getString(key: CacheConstants.userPhone) ?? '',
      anotherMobileNumber:
          CacheHelper.getString(key: CacheConstants.anotherPhonreNumber) ?? '',
      userName: CacheHelper.getString(key: CacheConstants.userName) ?? '',
      password: CacheHelper.getString(key: CacheConstants.password) ?? '',
      cityId: CacheHelper.getInt(key: CacheConstants.regionId) ?? 0,
      genderId: CacheHelper.getInt(key: CacheConstants.gender) ?? 0,
      specializationIds:
          CacheHelper.getIntList(key: CacheConstants.spicializationNames)
              as List<int>,
    );

    result.fold(
      (failure) {
        emit(DoctorAuthError(failure));
        return Left(failure);
      },
      (success) {
        emit(DoctorAuthSuccess('success'));
        return Right(success);
      },
    );

    return result;
  }
}
