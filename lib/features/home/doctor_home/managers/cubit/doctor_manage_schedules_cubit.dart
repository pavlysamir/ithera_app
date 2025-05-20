import 'package:bloc/bloc.dart';
import 'package:ithera_app/features/home/doctor_home/data/models/manage_schedules_model.dart';
import 'package:ithera_app/features/home/doctor_home/data/repos/manage_schedules_booking_repo.dart';
import 'package:meta/meta.dart';

part 'doctor_manage_schedules_state.dart';

class DoctorManageSchedulesCubit extends Cubit<DoctorManageSchedulesState> {
  DoctorManageSchedulesCubit(
    this._manageSchedulesBookingRepo,
  ) : super(DoctorManageSchedulesInitial());

  final ManageSchedulesBookingRepo _manageSchedulesBookingRepo;

  Future<void> manageSchedulesBooking(
      {required ManageSchedulesModel model}) async {
    emit(DoctorManageSchedulesLoading());
    try {
      final response = await _manageSchedulesBookingRepo.manageSchedulesBooking(
          model: model);
      emit(DoctorManageSchedulesSuccess(message: response));
    } catch (e) {
      emit(DoctorManageSchedulesError(errorMessage: e.toString()));
    }
  }
}
