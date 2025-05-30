import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ithera_app/features/booking/patient_booking/data/repos/patient_booking_repo.dart';

part 'patient_booking_state.dart';

class PatientBookingCubit extends Cubit<PatientBookingState> {
  PatientBookingCubit(this._patientBookingRepo)
      : super(PatientBookingInitial());
  final PatientBookingRepo _patientBookingRepo;

  // Future<void> getPatientBookings({required int status}) async {
  //   emit(PatientBookingLoading());
  //   final result = await _patientBookingRepo.getPatientBookings(status: status);
  //   result.fold(
  //     (error) => emit(PatientBookingError(error)),
  //     (bookings) => emit(PatientBookingLoaded(bookings)),
  //   );
  // }
  // Future<void> refreshBookings({required int status}) async {
  //   emit(PatientBookingLoading());
  //   final result = await _patientBookingRepo.getPatientBookings(status: status);
  //   result.fold(
  //     (error) => emit(PatientBookingError(error)),
  //     (bookings) => emit(PatientBookingRefreshed(bookings)),
  //   );
  // }
}
