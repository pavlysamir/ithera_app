import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/features/home/doctor_home/data/models/doctor_schadules_model.dart';
import 'package:ithera_app/features/home/doctor_home/data/models/manage_schedules_model.dart';
import 'package:ithera_app/features/home/doctor_home/data/repos/manage_schedules_booking_repo.dart';
import 'package:meta/meta.dart';
part 'doctor_manage_schedules_state.dart';

class DoctorManageSchedulesCubit extends Cubit<DoctorManageSchedulesState> {
  DoctorManageSchedulesCubit(
    this._manageSchedulesBookingRepo,
  ) : super(DoctorManageSchedulesInitial());

  final ManageSchedulesBookingRepo _manageSchedulesBookingRepo;

  static DoctorManageSchedulesCubit get(context) => BlocProvider.of(context);

  Future<void> manageSchedulesBooking({
    required DateTime selectedDate,
    required List<String> selectedDays,
    required List<String> timeRanges,
    required List<int> selectedRegionIds,
  }) async {
    emit(DoctorManageSchedulesLoading());
    final List<String> weekDays = [
      'السبت',
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة'
    ];

    // تحويل الأيام لأرقام
    final dayIndices =
        selectedDays.map((day) => weekDays.indexOf(day)).toList();

    final schedules = generateSchedules(timeRanges, dayIndices);

    // تجهيز الـ Regions
    final regions = selectedRegionIds
        .map((regionId) => RegionsModel(
            regionId: regionId, days: dayIndices, schedules: schedules))
        .toList();

    // تنسيق التاريخ
    final formattedDate = selectedDate.toUtc().toIso8601String();

    ManageSchedulesModel model = ManageSchedulesModel(
      doctorId: CacheHelper.getInt(key: CacheConstants.userId)!,
      startDate: formattedDate,
      regions: regions,
    );

    final response = await _manageSchedulesBookingRepo.manageSchedulesBooking(
        model: model.toJson());
    print('-------------------------------------------------');
    print(jsonEncode(model.toJson()));
    print('-------------------------------------------------');

    response.fold(
      (failure) {
        emit(DoctorManageSchedulesError(errorMessage: failure));
      },
      (success) async {
        if (isClosed) return;
        emit(DoctorManageSchedulesSuccess(message: success));
        await Future.delayed(const Duration(milliseconds: 100));
        if (isClosed) return;
        await getManageSchedules(forseRefresh: true);
      },
    );
  }

  // تجهيز الـ Schedules
  List<SchedulesModel> generateSchedules(
      List<String> timeRanges, List<int> days) {
    return timeRanges.map((range) {
      final times = range.split(' ')[0].split('-');
      return SchedulesModel(
        startTime: "${times[0]}:00",
        endTime: "${times[1]}:00",
      );
    }).toList();
  }

  bool _feachData = false;
  Future<void> getManageSchedules({bool forseRefresh = false}) async {
    if (_feachData && !forseRefresh) return;

    if (isClosed) return; // ✅ مهم جدًا

    emit(GetDoctorSchedulesLoading());

    final response = await _manageSchedulesBookingRepo.getDoctorSchedules();

    if (isClosed) return; // ✅ مرة تانية بعد await

    response.fold(
      (failure) {
        if (!isClosed) {
          emit(GetDoctorSchedulesError(errorMessage: failure));
        }
      },
      (data) {
        _feachData = true;
        if (!isClosed) {
          emit(GetDoctorSchedulesSuccess(data: data));
        }
      },
    );
  }

  Future<void> deleteDoctorSchadules(
      {required int regionId, required int scheduleId}) async {
    if (isClosed) return;

    emit(DeleteDoctorSchedulesLoading());

    final response = await _manageSchedulesBookingRepo.deleteDoctorSchedules(
      regionId: regionId,
      scheduleId: scheduleId,
    );

    if (isClosed) return; // ✅ مرة تانية بعد await

    response.fold(
      (failure) {
        if (!isClosed) {
          emit(DeleteDoctorSchedulesError(errorMessage: failure));
        }
      },
      (data) {
        if (!isClosed) {
          emit(DeleteDoctorSchedulesSuccess(message: data));
        }
      },
    );
  }
}
