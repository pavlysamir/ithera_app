import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ithera_app/features/booking/patient_booking/data/models/patient_booking_model.dart';
import 'package:ithera_app/features/booking/patient_booking/data/repos/patient_booking_repo.dart';

part 'patient_booking_state.dart';

class PatientBookingCubit extends Cubit<PatientBookingState> {
  PatientBookingCubit(this._patientBookingRepo)
      : super(PatientBookingInitial());
  final PatientBookingRepo _patientBookingRepo;

  bool _hasInitialized = false;

  Future<void> initializeIfNeeded() async {
    if (!_hasInitialized && state is PatientBookingInitial) {
      _hasInitialized = true;
      emit(const PatientBookingLoading([], []));

      // نحمّل البيانات بشكل متوازي
      final results = await Future.wait([
        _patientBookingRepo.getPatientBookings(status: 0), // active
        _patientBookingRepo.getPatientBookings(status: 1), // last
      ]);

      List<PatientBookingModel> activeBookings = [];
      List<PatientBookingModel> lastBookings = [];
      String? errorMessage;

      // معالجة نتيجة الـ active bookings
      results[0].fold(
        (error) => errorMessage ??= error,
        (bookings) => activeBookings = bookings,
      );

      // معالجة نتيجة الـ last bookings
      results[1].fold(
        (error) => errorMessage ??= error,
        (bookings) => lastBookings = bookings,
      );

      // إرسال الحالة النهائية
      if (errorMessage != null) {
        emit(PatientBookingError(errorMessage!, activeBookings, lastBookings));
      } else {
        emit(PatientBookingLoaded(activeBookings, lastBookings));
      }
    }
  }

  Future<void> refresh() async {
    _hasInitialized = false;
    emit(PatientBookingInitial());
    await initializeIfNeeded();
  }

  Future<void> getActivePatientBookings({required int status}) async {
    final currentState = state;
    List<PatientBookingModel> lastBookings = [];

    // احتفظ بالـ last bookings الحالية
    if (currentState is PatientBookingLoading) {
      lastBookings = currentState.lastBookings;
    } else if (currentState is PatientBookingLoaded) {
      lastBookings = currentState.lastBookings;
    } else if (currentState is PatientBookingError) {
      lastBookings = currentState.lastBookings;
    }

    final result = await _patientBookingRepo.getPatientBookings(status: 0);
    result.fold(
      (error) {
        // احتفظ بالـ active bookings الحالية في حالة الخطأ
        List<PatientBookingModel> currentActiveBookings = [];
        if (currentState is PatientBookingLoaded) {
          currentActiveBookings = currentState.activeBookings;
        } else if (currentState is PatientBookingError) {
          currentActiveBookings = currentState.activeBookings;
        }
        emit(PatientBookingError(error, currentActiveBookings, lastBookings));
      },
      (activeBookings) {
        emit(PatientBookingLoaded(activeBookings, lastBookings));
      },
    );
  }

  Future<void> getLastPatientBookings({required int status}) async {
    final currentState = state;
    List<PatientBookingModel> activeBookings = [];

    // احتفظ بالـ active bookings الحالية
    if (currentState is PatientBookingLoading) {
      activeBookings = currentState.activeBookings;
    } else if (currentState is PatientBookingLoaded) {
      activeBookings = currentState.activeBookings;
    } else if (currentState is PatientBookingError) {
      activeBookings = currentState.activeBookings;
    }

    final result = await _patientBookingRepo.getPatientBookings(status: 1);
    result.fold(
      (error) {
        // احتفظ بالـ last bookings الحالية في حالة الخطأ
        List<PatientBookingModel> currentLastBookings = [];
        if (currentState is PatientBookingLoaded) {
          currentLastBookings = currentState.lastBookings;
        } else if (currentState is PatientBookingError) {
          currentLastBookings = currentState.lastBookings;
        }
        emit(PatientBookingError(error, activeBookings, currentLastBookings));
      },
      (lastBookings) {
        emit(PatientBookingLoaded(activeBookings, lastBookings));
      },
    );
  }
}
