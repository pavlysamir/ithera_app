part of 'patient_booking_cubit.dart';

abstract class PatientBookingState extends Equatable {
  const PatientBookingState();

  @override
  List<Object> get props => [];
}

class PatientBookingInitial extends PatientBookingState {}

class PatientBookingLoading extends PatientBookingState {
  final List<PatientBookingModel> activeBookings;
  final List<PatientBookingModel> lastBookings;

  const PatientBookingLoading(this.activeBookings, this.lastBookings);

  @override
  List<Object> get props => [activeBookings, lastBookings];
}

class PatientBookingLoaded extends PatientBookingState {
  final List<PatientBookingModel> activeBookings;
  final List<PatientBookingModel> lastBookings;

  const PatientBookingLoaded(this.activeBookings, this.lastBookings);

  @override
  List<Object> get props => [activeBookings, lastBookings];
}

class PatientBookingError extends PatientBookingState {
  final String message;
  final List<PatientBookingModel> activeBookings;
  final List<PatientBookingModel> lastBookings;

  const PatientBookingError(
      this.message, this.activeBookings, this.lastBookings);

  @override
  List<Object> get props => [message, activeBookings, lastBookings];
}
