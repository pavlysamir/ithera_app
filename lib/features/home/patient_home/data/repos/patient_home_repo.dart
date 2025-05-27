import 'package:dartz/dartz.dart';
import 'package:ithera_app/core/api/dio_consumer.dart';
import 'package:ithera_app/core/api/end_ponits.dart';
import 'package:ithera_app/core/api/general_response_model.dart';
import 'package:ithera_app/core/errors/exceptions.dart';
import 'package:ithera_app/features/home/patient_home/data/models/book_session_request_model.dart';
import 'package:ithera_app/features/home/patient_home/data/models/doctors_model.dart';

class PatientHomeRepo {
  final DioConsumer _dio;
  PatientHomeRepo(this._dio);

  Future<Either<String, DoctorModelResponse>> fetchDoctors(
      int pageNumber) async {
    try {
      final response = await _dio.post(
        EndPoint.getAllDoctors,
        data: {'pageNumber': pageNumber, 'pageSize': 10},
      );

      final parsed = BaseResponse<DoctorModelResponse>.fromJson(
        response,
        (data) => DoctorModelResponse.fromJson(data),
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

  Future<Either<String, String>> bookSession(BookingRequest request) async {
    try {
      final response = await _dio.post(
        EndPoint.bookSession,
        data: request.toJson(),
      );

      return Right(response['message'] ?? 'تم الحجز بنجاح');
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? 'حدث خطأ ما');
    }
  }
}
