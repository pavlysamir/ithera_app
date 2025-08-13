import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ithera_app/features/notification/data/models/notifications_model.dart';
import 'package:ithera_app/features/notification/data/repo/notification_repo.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._notificationsRepo) : super(NotificationsInitial());

  final NotificationRepo _notificationsRepo;

  Future<void> getNotificatios({required int role, required int userId}) async {
    emit(GetNotificationLoading());
    final result = await _notificationsRepo.getNotification(
      role: role,
      userId: userId,
    );
    result.fold(
      (error) => emit(GetNotificationError(errorMessage: error)),
      (patientData) => emit(GetNotificationLoaded(
          notificationsResponse: patientData.responseData)),
    );
  }
}
