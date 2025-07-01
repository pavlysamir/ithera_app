import 'package:dartz/dartz.dart';
import 'package:ithera_app/core/api/dio_consumer.dart';
import 'package:ithera_app/core/api/end_ponits.dart';
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
}
