import 'package:dartz/dartz.dart';
import 'package:ithera_app/core/api/api_consumer.dart';
import 'package:ithera_app/core/api/end_ponits.dart';
import 'package:ithera_app/core/api/general_response_model.dart';
import 'package:ithera_app/core/errors/exceptions.dart';
import 'package:ithera_app/features/auth/data/models/login_model.dart';
import 'package:ithera_app/features/auth/data/models/patient_register_model.dart';

class AuthRepo {
  final ApiConsumer api;
  AuthRepo({required this.api});

  Future<Either<String, LoginData>> login(
      String mobileNumber, String password, int roleId) async {
    try {
      final response = await api.get(
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

  // Future<void> doctorRegister(
  //   String email,
  //   String phoneNumber,
  //   String anotherMobileNumber,
  //   String userName,
  //   String password,
  //   int cityId,
  //   int genderId,
  //   List<int> specializationIds,
  // ) {}
}
