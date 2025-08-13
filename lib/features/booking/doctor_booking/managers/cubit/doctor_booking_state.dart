part of 'doctor_booking_cubit.dart';

sealed class DoctorBookingState extends Equatable {
  const DoctorBookingState();

  @override
  List<Object> get props => [];
}

final class DoctorBookingInitial extends DoctorBookingState {}

class DoctorBookingLoading extends DoctorBookingState {
  final List<DoctorBookingModel> activeBookings;
  final List<DoctorBookingModel> lastBookings;
  final List<DoctorBookingModel> unCompletedBookings;

  const DoctorBookingLoading(
      this.activeBookings, this.lastBookings, this.unCompletedBookings);

  @override
  List<Object> get props => [activeBookings, lastBookings, unCompletedBookings];
}

class DoctorBookingLoaded extends DoctorBookingState {
  final List<DoctorBookingModel> activeBookings;
  final List<DoctorBookingModel> lastBookings;
  final List<DoctorBookingModel> unCompletedBookings;

  const DoctorBookingLoaded(
      this.activeBookings, this.lastBookings, this.unCompletedBookings);

  @override
  List<Object> get props => [activeBookings, lastBookings, unCompletedBookings];
}

class DoctorBookingError extends DoctorBookingState {
  final String message;
  final List<DoctorBookingModel> activeBookings;
  final List<DoctorBookingModel> lastBookings;
  final List<DoctorBookingModel> unCompletedBookings;

  const DoctorBookingError(this.message, this.activeBookings, this.lastBookings,
      this.unCompletedBookings);

  @override
  List<Object> get props =>
      [message, activeBookings, lastBookings, unCompletedBookings];
}
