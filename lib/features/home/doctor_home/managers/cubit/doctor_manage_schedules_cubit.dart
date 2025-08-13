import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
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

  bool _fetchData = false;
  DoctorScheduleResponse? _cachedData;

  Future<void> manageSchedulesBooking({
    required DateTime selectedDate,
    required List<String> selectedDays,
    required List<String> timeRanges,
    required List<int> selectedRegionIds,
  }) async {
    if (isClosed) return;

    emit(DoctorManageSchedulesLoading());

    try {
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

      if (kDebugMode) {
        print('-------------------------------------------------');
      }
      if (kDebugMode) {
        print(jsonEncode(model.toJson()));
      }
      if (kDebugMode) {
        print('-------------------------------------------------');
      }

      if (isClosed) return;

      response.fold(
        (failure) {
          if (!isClosed) {
            emit(DoctorManageSchedulesError(errorMessage: failure));
          }
        },
        (success) async {
          if (!isClosed) {
            emit(DoctorManageSchedulesSuccess(message: success));
            // Reset fetch flag to force refresh
            _fetchData = false;
            // Small delay to ensure state is processed
            await Future.delayed(const Duration(milliseconds: 200));
            if (!isClosed) {
              await getManageSchedules(forceRefresh: true);
            }
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(DoctorManageSchedulesError(errorMessage: e.toString()));
      }
    }
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

  Future<void> getManageSchedules({bool forceRefresh = false}) async {
    if (isClosed) return;

    // If we already have data and not forcing refresh, return cached data
    if (_fetchData && !forceRefresh && _cachedData != null) {
      if (!isClosed) {
        emit(GetDoctorSchedulesSuccess(data: _cachedData!));
      }
      return;
    }

    if (!isClosed) {
      emit(GetDoctorSchedulesLoading());
    }

    try {
      final response = await _manageSchedulesBookingRepo.getDoctorSchedules();

      if (isClosed) return;

      response.fold(
        (failure) {
          if (!isClosed) {
            emit(GetDoctorSchedulesError(errorMessage: failure));
          }
        },
        (data) {
          _fetchData = true;
          _cachedData = data;
          if (!isClosed) {
            emit(GetDoctorSchedulesSuccess(data: data));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(GetDoctorSchedulesError(errorMessage: e.toString()));
      }
    }
  }

  Future<void> deleteDoctorSchedules(
      {required int regionId, required int scheduleId}) async {
    if (isClosed) return;

    emit(DeleteDoctorSchedulesLoading());

    try {
      final response = await _manageSchedulesBookingRepo.deleteDoctorSchedules(
        regionId: regionId,
        scheduleId: scheduleId,
      );

      if (isClosed) return;

      response.fold(
        (failure) {
          if (!isClosed) {
            emit(DeleteDoctorSchedulesError(errorMessage: failure));
          }
        },
        (data) async {
          if (!isClosed) {
            emit(DeleteDoctorSchedulesSuccess(message: data));
            // Reset cache to force fresh data
            _fetchData = false;
            _cachedData = null;
            // Small delay before refreshing
            await Future.delayed(const Duration(milliseconds: 100));
            if (!isClosed) {
              await getManageSchedules(forceRefresh: true);
            }
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(DeleteDoctorSchedulesError(errorMessage: e.toString()));
      }
    }
  }

  void resetState() {
    if (!isClosed) {
      _fetchData = false;
      _cachedData = null;
      emit(DoctorManageSchedulesInitial());
    }
  }

  @override
  Future<void> close() {
    // Clear any cached data
    _cachedData = null;
    _fetchData = false;
    return super.close();
  }
}
