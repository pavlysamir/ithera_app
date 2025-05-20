import 'package:ithera_app/core/api/dio_consumer.dart';
import 'package:ithera_app/core/api/end_ponits.dart';
import 'package:ithera_app/core/errors/exceptions.dart';
import 'package:ithera_app/features/home/doctor_home/data/models/manage_schedules_model.dart';

class ManageSchedulesBookingRepo {
  final DioConsumer _dio;

  ManageSchedulesBookingRepo(
    this._dio,
  );

  Future<String> manageSchedulesBooking(
      {required ManageSchedulesModel model}) async {
    try {
      var response = await _dio.post(EndPoint.manageSchedules, data: model);

      return response['message'];
    } on ServerException catch (e) {
      if (e.errModel?.errorMessage != null) {
        return e.errModel!.errorMessage!;
      } else {
        return 'حدث خطاء ما';
      }
    }
  }
}
