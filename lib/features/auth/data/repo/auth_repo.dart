import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ithera_app/core/api/api_consumer.dart';
import 'package:ithera_app/core/api/end_ponits.dart';
import 'package:ithera_app/core/api/general_response_model.dart';
import 'package:ithera_app/core/errors/exceptions.dart';
import 'package:ithera_app/features/auth/data/models/doctor_register_model.dart';
import 'package:ithera_app/features/auth/data/models/login_model.dart';
import 'package:ithera_app/features/auth/data/models/patient_register_model.dart';

class AuthRepo {
  final ApiConsumer api;
  AuthRepo({required this.api});

  Future<Either<String, LoginData>> login(
      String mobileNumber, String password, int roleId) async {
    try {
      final response = await api.post(
        EndPoint.login,
        queryParameters: {
          ApiKey.mobNumber: mobileNumber,
          ApiKey.password: password,
          ApiKey.role: roleId,
        },
      );
      final parsed = BaseResponse<LoginData>.fromJson(
        response,
        (data) => LoginData.fromJson(data),
      );

      if (parsed.success && parsed.data != null) {
        return Right(parsed.data!);
      } else {
        return Left(parsed.message);
      }
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? 'حدث خطأ ما');
    }
  }

  Future<Either<String, PatientRegisterModel>> patientRegister({
    required String email,
    required String phoneNumber,
    required String userName,
    required String password,
    required int cityId,
    required int regionId,
    required int genderId,
  }) async {
    try {
      final response = await api.post(EndPoint.patientRegister, data: {
        ApiKey.email: email,
        ApiKey.userName: userName,
        ApiKey.password: password,
        ApiKey.phoneNumber: phoneNumber,
        ApiKey.cityId: cityId,
        ApiKey.regionId: regionId,
        ApiKey.gender: genderId,
        ApiKey.dateOfBirth: DateTime.now().toIso8601String(),
      });
      final parsed = BaseResponse<PatientRegisterModel>.fromJson(
        response,
        (data) => PatientRegisterModel.fromJson(data),
      );

      if (parsed.success && parsed.data != null) {
        return Right(parsed.data!);
      } else {
        return Left(parsed.message);
      }
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? 'حدث خطأ ما');
    }
  }

  Future<Either<String, DoctorRegisterModel>> doctorRegister({
    required String email,
    required String phoneNumber,
    required String anotherMobileNumber,
    required String userName,
    required String password,
    required int cityId,
    required int genderId,
    required List<int> specializationIds,
  }) async {
    try {
      final response = await api.post(EndPoint.doctorRegister, data: {
        ApiKey.email: email,
        ApiKey.userName: userName,
        ApiKey.password: password,
        ApiKey.phoneNumber: phoneNumber,
        ApiKey.anotherMobileNumber: anotherMobileNumber,
        ApiKey.cityId: cityId,
        ApiKey.gender: genderId,
        ApiKey.specializationFieldIds: specializationIds,
      });
      final parsed = BaseResponse<DoctorRegisterModel>.fromJson(
        response,
        (data) => DoctorRegisterModel.fromJson(data),
      );

      if (parsed.success && parsed.data != null) {
        return Right(parsed.data!);
      } else {
        return Left(parsed.message);
      }
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? 'حدث خطأ ما');
    }
  }

  Future<Either<String, void>> addFile(
      {required String userId,
      required String fileRoleId,
      required List<String> dataType,
      required List<File> file}) async {
    try {
      // Create FormData
      FormData formData = FormData();

      // Add userId field
      formData.fields.add(MapEntry("file.userid", userId));
      // Add fileRoleId field
      formData.fields.add(MapEntry("file.fileRoleId", fileRoleId));

      // Add files and their types
      for (int i = 0; i < file.length; i++) {
        formData.fields.add(MapEntry("file.file[$i].fileTypeId", dataType[i]));
        formData.files.add(
          MapEntry(
            "file.file[$i].file",
            await MultipartFile.fromFile(file[i].path,
                filename: file[i].path.split('/').last),
          ),
        );
      }

      // Sending the request
      final response = await api.post(EndPoint.addFile, data: formData);

      // Check the response and return accordingly
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return const Left('Failed to upload files');
      }
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? '');
    } catch (e) {
      return const Left('An unexpected error occurred');
    }
  }
}
