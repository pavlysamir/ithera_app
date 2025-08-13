import 'package:dartz/dartz.dart';
import 'package:ithera_app/core/api/dio_consumer.dart';
import 'package:ithera_app/core/api/end_ponits.dart';
import 'package:ithera_app/core/api/general_response_model.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/errors/exceptions.dart';
import 'package:ithera_app/features/home/doctor_home/data/models/doctor_schadules_model.dart';
import 'package:ithera_app/features/settings/doctors_settings/data/models/doctor_walled_data_model.dart';
import 'package:ithera_app/features/settings/doctors_settings/data/models/patient_data_model.dart';

class SettingsRepo {
  final DioConsumer _dioConsumer;

  SettingsRepo(this._dioConsumer);
  Future<Either<String, WalletResponseModel>> getDoctorWalletDetails() async {
    try {
      final response = await _dioConsumer.get(
        EndPoint.getDoctorWalletData,
      );

      final parsed = WalletResponseModel.fromJson(response);

      return Right(parsed);
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? 'حدث خطأ ما');
    }
  }

  Future<Either<String, String>> submitDoctorWalletRequest({
    required int amount,
    required int walletType,
    required String mobileNumber,
    required String transferFromNumber,
    required int type,
    String? withdrawalReason,
  }) async {
    try {
      final response = await _dioConsumer.post(
        EndPoint.submitDoctorWalletRequest,
        data: {
          "amount": amount,
          "type": type,
          "doctorId": CacheHelper.getInt(key: CacheConstants.userId),
          "mobileNumber": mobileNumber,
          "walletProvider": walletType,
          "transferFromNumber": transferFromNumber,
          if (withdrawalReason != null) "withdrawalReason": withdrawalReason,
        },
      );

      final parsed = BaseAuthResponse<int>.fromJson(
        response,
        (data) => data,
      );
      if (parsed.success) {
        return Right(parsed.message);
      } else {
        return Left(parsed.message);
      }
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? 'حدث خطأ ما');
    }
  }

  Future<Either<String, DoctorScheduleResponse>> getDoctorData() async {
    try {
      var response = await _dioConsumer.get(
        EndPoint.getDoctorDataEndPoint(
          CacheHelper.getInt(key: CacheConstants.userId),
        ),
      );

      DoctorScheduleResponse model = DoctorScheduleResponse.fromJson(response);
      return Right(model);

      // if (parsed.success && parsed.data != null) {
      //   return Right(parsed.data!);
      // } else {
      //   return Left(parsed.message);
      // }
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? 'حدث خطأ ما');
    }
  }

  Future<Either<String, PatientData>> getPatientrData() async {
    try {
      var response = await _dioConsumer.get(EndPoint.getPatientData);

      PatientDataResponse model = PatientDataResponse.fromJson(response);
      return Right(model.responseData!);
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? 'حدث خطأ ما');
    }
  }

  Future<Either<String, String>> updateDoctorData(
      {required Map<String, dynamic> body}) async {
    try {
      var response =
          await _dioConsumer.put(EndPoint.updateDoctorData, data: body);

      if (response['isSuccess'] == false) {
        return Left(response['message'] ?? 'حدث خطاء ما');
      } else {
        return const Right('تم التعديل بنجاح');
      }
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? 'حدث خطأ ما');
    }
  }
}
