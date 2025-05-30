import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'patient_booking_state.dart';

class PatientBookingCubit extends Cubit<PatientBookingState> {
  PatientBookingCubit() : super(PatientBookingInitial());
}
