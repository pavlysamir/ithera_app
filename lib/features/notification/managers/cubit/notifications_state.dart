part of 'notifications_cubit.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

final class NotificationsInitial extends NotificationsState {}

final class GetNotificationLoading extends NotificationsState {}

final class GetNotificationLoaded extends NotificationsState {
  final List<NotificationItem> notificationsResponse;
  const GetNotificationLoaded({required this.notificationsResponse});
}

final class GetNotificationError extends NotificationsState {
  final String errorMessage;
  const GetNotificationError({required this.errorMessage});
}

final class GetBookingDetailsLoading extends NotificationsState {}

final class GetBookingDetailsLoaded extends NotificationsState {
  final BookingDetailsData bookingDetailsResponse;
  const GetBookingDetailsLoaded({required this.bookingDetailsResponse});
}

final class GetBookingDetailsError extends NotificationsState {
  final String errorMessage;
  const GetBookingDetailsError({required this.errorMessage});
}
