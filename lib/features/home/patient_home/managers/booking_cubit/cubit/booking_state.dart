part of 'booking_cubit.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

final class SuccessfulPickImage extends BookingState {}

final class FailPickImage extends BookingState {}

final class BookingLoading extends BookingState {}

final class SuccessfulBookSession extends BookingState {
  final String successMessage;

  SuccessfulBookSession(this.successMessage);
}

final class FailBookSession extends BookingState {
  final String errorMessage;

  FailBookSession(this.errorMessage);
}
