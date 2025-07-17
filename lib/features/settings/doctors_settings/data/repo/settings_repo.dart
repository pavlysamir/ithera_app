import 'package:dartz/dartz.dart';
import 'package:ithera_app/core/api/dio_consumer.dart';
import 'package:ithera_app/core/api/end_ponits.dart';
import 'package:ithera_app/core/api/general_response_model.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/errors/exceptions.dart';
import 'package:ithera_app/features/settings/doctors_settings/data/models/doctor_walled_data_model.dart';

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
}
