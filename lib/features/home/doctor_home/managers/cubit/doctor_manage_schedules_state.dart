part of 'doctor_manage_schedules_cubit.dart';

@immutable
sealed class DoctorManageSchedulesState {}

final class DoctorManageSchedulesInitial extends DoctorManageSchedulesState {}

final class DoctorManageSchedulesSuccess extends DoctorManageSchedulesState {
  final String message;

  DoctorManageSchedulesSuccess({required this.message});
}

final class DoctorManageSchedulesError extends DoctorManageSchedulesState {
  final String errorMessage;

  DoctorManageSchedulesError({required this.errorMessage});
}

final class DoctorManageSchedulesLoading extends DoctorManageSchedulesState {}

final class GetDoctorSchedulesSuccess extends DoctorManageSchedulesState {
  final DoctorScheduleResponse data;

  GetDoctorSchedulesSuccess({required this.data});
}

final class GetDoctorSchedulesError extends DoctorManageSchedulesState {
  final String errorMessage;

  GetDoctorSchedulesError({required this.errorMessage});
}

final class GetDoctorSchedulesLoading extends DoctorManageSchedulesState {}

final class DeleteDoctorSchedulesSuccess extends DoctorManageSchedulesState {
  final String message;

  DeleteDoctorSchedulesSuccess({required this.message});
}

final class DeleteDoctorSchedulesError extends DoctorManageSchedulesState {
  final String errorMessage;

  DeleteDoctorSchedulesError({required this.errorMessage});
}

final class DeleteDoctorSchedulesLoading extends DoctorManageSchedulesState {}
