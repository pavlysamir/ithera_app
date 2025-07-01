import 'package:dartz/dartz.dart';
import 'package:ithera_app/core/api/dio_consumer.dart';
import 'package:ithera_app/core/api/end_ponits.dart';
import 'package:ithera_app/core/api/general_response_model.dart';
import 'package:ithera_app/core/errors/exceptions.dart';
import 'package:ithera_app/features/booking/doctor_booking/data/models/doctor_booking_model.dart';

class DoctorBookingRepo {
  final DioConsumer _dioConsumer;
  DoctorBookingRepo(this._dioConsumer);
  Future<Either<String, List<DoctorBookingModel>>> getDoctorBookings({
    required int status,
  }) async {
    try {
      final response = await _dioConsumer.get(
        EndPoint.getAllDoctorsBooking,
        queryParameters: {'status': status},
      );

      final parsed = BaseResponse<List<DoctorBookingModel>>.fromJson(
        response,
        (data) =>
            (data as List).map((e) => DoctorBookingModel.fromJson(e)).toList(),
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
}
