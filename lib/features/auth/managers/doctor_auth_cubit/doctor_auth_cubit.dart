import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

part 'doctor_auth_state.dart';

class DoctorAuthCubit extends Cubit<DoctorAuthState> {
  DoctorAuthCubit() : super(DoctorAuthInitial());

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
}
