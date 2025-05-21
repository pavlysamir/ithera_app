import 'package:dartz/dartz.dart';
import 'package:ithera_app/core/api/dio_consumer.dart';
import 'package:ithera_app/core/api/end_ponits.dart';
import 'package:ithera_app/core/errors/exceptions.dart';

class ManageSchedulesBookingRepo {
  final DioConsumer _dio;

  ManageSchedulesBookingRepo(
    this._dio,
  );

  Future<Either<String, String>> manageSchedulesBooking(
      {required Map<String, dynamic> model}) async {
    try {
      var response = await _dio.post(EndPoint.manageSchedules, data: model);

      return Right(response['message']);
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? 'حدث خطأ ما');
    }
  }
}
