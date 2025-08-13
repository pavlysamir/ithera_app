import 'package:dartz/dartz.dart';
import 'package:ithera_app/core/api/api_consumer.dart';
import 'package:ithera_app/core/api/end_ponits.dart';
import 'package:ithera_app/core/errors/exceptions.dart';
import 'package:ithera_app/features/notification/data/models/notifications_model.dart';

class NotificationRepo {
  final ApiConsumer api;

  NotificationRepo(this.api);

  Future<Either<String, NotificationsResponse>> getNotification(
      {required int role, required int userId}) async {
    try {
      final response = await api.get(EndPoint.getNotification,
          queryParameters: {ApiKey.role: role, ApiKey.userId: userId});

      NotificationsResponse model = NotificationsResponse.fromJson(response);

      if (response['status'] == false) {
        return Left(response['message']);
      }

      return Right(model);
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? 'حدث خطأ ما');
    }
  }
}
