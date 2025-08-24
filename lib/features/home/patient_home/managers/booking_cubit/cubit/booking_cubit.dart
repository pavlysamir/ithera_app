import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ithera_app/features/home/patient_home/data/models/book_session_request_model.dart';
import 'package:ithera_app/features/home/patient_home/data/repos/patient_home_repo.dart';
import 'package:equatable/equatable.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit(this._patientHomeRepo) : super(const BookingInitial());
  final PatientHomeRepo _patientHomeRepo;
  String? base64BackImage;
  bool _isImagePickingInProgress = false;

  File? file;
  String? fileName;

  Future<void> pickCameraImage() async {
    // Prevent multiple simultaneous image picking operations
    if (_isImagePickingInProgress || isClosed) return;

    _isImagePickingInProgress = true;

    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      // Check if cubit is still active
      if (isClosed) return;

      if (image != null) {
        // Read the image file
        final bytes = await File(image.path).readAsBytes();

        // Check if cubit is still active before continuing
        if (isClosed) return;

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

          // Only emit if cubit is still active
          if (!isClosed) {
            emit(SuccessfulPickImage(file!));
          }
        } else {
          if (!isClosed) {
            emit(const FailPickImage());
          }
        }
      } else {
        if (!isClosed) {
          emit(const FailPickImage());
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
      if (!isClosed) {
        emit(const FailPickImage());
      }
    } finally {
      _isImagePickingInProgress = false;
    }
  }

  Future<void> bookSession({required BookingRequest request}) async {
    // Check if cubit is closed before starting
    if (isClosed) return;

    emit(const BookingLoading());

    try {
      final result = await _patientHomeRepo.bookSession(request);

      // Check if cubit is still active before emitting
      if (isClosed) return;

      result.fold(
        (error) {
          if (!isClosed) {
            emit(FailBookSession(error));
          }
        },
        (successMessage) {
          if (!isClosed) {
            emit(SuccessfulBookSession(successMessage));
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error booking session: $e');
      }
      if (!isClosed) {
        emit(const FailBookSession('حدث خطأ أثناء الحجز'));
      }
    }
  }

  // Clear data method
  void clearData() {
    base64BackImage = null;
    file = null;
    fileName = null;
    _isImagePickingInProgress = false;
  }

  @override
  Future<void> close() {
    clearData();
    return super.close();
  }
}
