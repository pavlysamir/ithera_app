import 'package:dartz/dartz.dart';
import 'package:ithera_app/core/api/dio_consumer.dart';
import 'package:ithera_app/core/api/end_ponits.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/errors/exceptions.dart';
import 'package:ithera_app/features/home/doctor_home/data/models/doctor_schadules_model.dart';

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

  Future<Either<String, DoctorScheduleResponse>> getDoctorSchedules() async {
    try {
      var response = await _dio.get(
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

  Future<Either<String, String>> deleteDoctorSchedules(
      {required int regionId, required int scheduleId}) async {
    try {
      var response = await _dio.delete(
        EndPoint.deleteDoctorSchedule(
          CacheHelper.getInt(key: CacheConstants.userId),
          regionId,
          scheduleId,
        ),
      );

      return Right(response['message']);

      // if (parsed.success && parsed.data != null) {
      //   return Right(parsed.data!);
      // } else {
      //   return Left(parsed.message);
      // }
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? 'حدث خطأ ما');
    }
  }
}
