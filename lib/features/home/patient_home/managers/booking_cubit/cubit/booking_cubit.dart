import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:ithera_app/features/home/patient_home/data/models/book_session_request_model.dart';
import 'package:ithera_app/features/home/patient_home/data/repos/patient_home_repo.dart';
import 'package:path/path.dart' as path;
import 'package:equatable/equatable.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit(this._patientHomeRepo) : super(const BookingInitial());
  final PatientHomeRepo _patientHomeRepo;
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
        emit(const SuccessfulPickImage());
      } else {
        emit(const FailPickImage());
      }
    } else {
      emit(const FailPickImage());
    }
  }

  Future<void> bookSession({required BookingRequest request}) async {
    emit(const BookingLoading());

    final result = await _patientHomeRepo.bookSession(request);
    result.fold(
      (error) {
        emit(FailBookSession(error));
      },
      (successMessage) {
        emit(SuccessfulBookSession(successMessage));
      },
    );
  }
}
