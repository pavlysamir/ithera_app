part of 'booking_cubit.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

final class SuccessfulPickImage extends BookingState {}

final class FailPickImage extends BookingState {}
