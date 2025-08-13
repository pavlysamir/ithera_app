import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ithera_app/features/booking/doctor_booking/data/booking_repo/doctor_booking_repo.dart';
import 'package:ithera_app/features/booking/doctor_booking/data/models/doctor_booking_model.dart';

part 'doctor_booking_state.dart';

class DoctorBookingCubit extends Cubit<DoctorBookingState> {
  DoctorBookingCubit(this._doctorsBookingRepo) : super(DoctorBookingInitial());

  final DoctorBookingRepo _doctorsBookingRepo;

  bool _hasInitialized = false;

  Future<void> initializeIfNeeded() async {
    if (!_hasInitialized && state is DoctorBookingInitial) {
      _hasInitialized = true;
      emit(const DoctorBookingLoading([], [], []));

      // نحمّل البيانات بشكل متوازي
      final results = await Future.wait([
        _doctorsBookingRepo.getDoctorBookings(status: 0), // active
        _doctorsBookingRepo.getDoctorBookings(status: 1), // last
        _doctorsBookingRepo.getDoctorBookings(status: 5), // unCompleted
      ]);

      List<DoctorBookingModel> currentBookings = [];
      List<DoctorBookingModel> lastBookings = [];
      List<DoctorBookingModel> unCompletedBookings = [];

      String? errorMessage;

      // معالجة نتيجة الـ active bookings
      results[0].fold(
        (error) => errorMessage ??= error,
        (bookings) => currentBookings = bookings,
      );

      // معالجة نتيجة الـ last bookings
      results[1].fold(
        (error) => errorMessage ??= error,
        (bookings) => lastBookings = bookings,
      );

      results[2].fold(
        (error) => errorMessage ??= error,
        (bookings) => unCompletedBookings = bookings,
      );

      // إرسال الحالة النهائية
      if (errorMessage != null) {
        emit(DoctorBookingError(
            errorMessage!, currentBookings, lastBookings, unCompletedBookings));
      } else {
        emit(DoctorBookingLoaded(
            currentBookings, lastBookings, unCompletedBookings));
      }
    }
  }

  Future<void> refresh() async {
    _hasInitialized = false;
    emit(DoctorBookingInitial());
    await initializeIfNeeded();
  }

  Future<void> getActiveDoctorBookings({required int status}) async {
    final currentState = state;
    List<DoctorBookingModel> lastBookings = [];
    List<DoctorBookingModel> unCompletedBookings = [];

    // احتفظ بالـ last bookings الحالية
    if (currentState is DoctorBookingLoading) {
      lastBookings = currentState.lastBookings;
      unCompletedBookings = currentState.unCompletedBookings;
    } else if (currentState is DoctorBookingLoaded) {
      lastBookings = currentState.lastBookings;
      unCompletedBookings = currentState.unCompletedBookings;
    } else if (currentState is DoctorBookingError) {
      lastBookings = currentState.lastBookings;
      unCompletedBookings = currentState.unCompletedBookings;
    }

    final result = await _doctorsBookingRepo.getDoctorBookings(status: 0);
    result.fold(
      (error) {
        // احتفظ بالـ active bookings الحالية في حالة الخطأ
        List<DoctorBookingModel> currentActiveBookings = [];
        if (currentState is DoctorBookingLoaded) {
          currentActiveBookings = currentState.activeBookings;
        } else if (currentState is DoctorBookingError) {
          currentActiveBookings = currentState.activeBookings;
        }
        emit(DoctorBookingError(
            error, currentActiveBookings, lastBookings, unCompletedBookings));
      },
      (activeBookings) {
        emit(DoctorBookingLoaded(
            activeBookings, lastBookings, unCompletedBookings));
      },
    );
  }

  Future<void> getLastDoctorBookings({required int status}) async {
    final currentState = state;
    List<DoctorBookingModel> activeBookings = [];
    List<DoctorBookingModel> unCompletedBookings = [];

    // احتفظ بالـ active bookings الحالية
    if (currentState is DoctorBookingLoading) {
      activeBookings = currentState.activeBookings;
      unCompletedBookings = currentState.unCompletedBookings;
    } else if (currentState is DoctorBookingLoaded) {
      activeBookings = currentState.activeBookings;
      unCompletedBookings = currentState.unCompletedBookings;
    } else if (currentState is DoctorBookingError) {
      activeBookings = currentState.activeBookings;
      unCompletedBookings = currentState.unCompletedBookings;
    }

    final result = await _doctorsBookingRepo.getDoctorBookings(status: 1);
    result.fold(
      (error) {
        // احتفظ بالـ last bookings الحالية في حالة الخطأ
        List<DoctorBookingModel> currentLastBookings = [];

        if (currentState is DoctorBookingLoaded) {
          currentLastBookings = currentState.lastBookings;
          unCompletedBookings = currentState.unCompletedBookings;
        } else if (currentState is DoctorBookingError) {
          currentLastBookings = currentState.lastBookings;
        }
        emit(DoctorBookingError(
            error, unCompletedBookings, currentLastBookings, activeBookings));
      },
      (lastBookings) {
        emit(DoctorBookingLoaded(
            activeBookings, lastBookings, unCompletedBookings));
      },
    );
  }

  Future<void> manageBookingStatus(
      {required int bookingId,
      required int status,
      String? reason,
      int? sessionId}) async {
    emit(ManageBookingDoctorLoading());
    final result = await _doctorsBookingRepo.manageBooking(
        bookingId: bookingId,
        status: status,
        reason: reason,
        sessionId: sessionId);
    result.fold(
      (error) => emit(ManageBookingDoctorError(error)),
      (bookings) => emit(ManageBookingDoctorLoaded(bookings)),
    );
  }
}
