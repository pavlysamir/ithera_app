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
