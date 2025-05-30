part of 'patient_booking_cubit.dart';

sealed class PatientBookingState extends Equatable {
  const PatientBookingState();

  @override
  List<Object> get props => [];
}

final class PatientBookingInitial extends PatientBookingState {}
