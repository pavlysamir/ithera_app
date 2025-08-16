part of 'doctor_auth_cubit.dart';

@immutable
sealed class DoctorAuthState {}

final class DoctorAuthInitial extends DoctorAuthState {}

final class SuccessfulPickImage extends DoctorAuthState {}

final class SuccessfulPickCv extends DoctorAuthState {}

final class FailPickImage extends DoctorAuthState {}

final class DoctorAuthLoading extends DoctorAuthState {}

final class DoctorAuthSuccess extends DoctorAuthState {
  final String successMessage;

  DoctorAuthSuccess(this.successMessage);
}

final class DoctorAuthError extends DoctorAuthState {
  final String errorMessage;

  DoctorAuthError(this.errorMessage);
}

final class CashedDoctorRegisterUserDataLoading extends DoctorAuthState {}

final class CashedDoctorRegisterUserDataSuccess extends DoctorAuthState {}
