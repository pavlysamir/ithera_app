part of 'patient_auth_cubit.dart';

@immutable
sealed class PatientAuthState {}

final class PatientAuthInitial extends PatientAuthState {}

final class CashedPatientRegisterUserDataLoading extends PatientAuthState {}

final class CashedPatientRegisterUserDataSuccess extends PatientAuthState {}

final class PatientAuthLoading extends PatientAuthState {}

final class PatientAuthSuccess extends PatientAuthState {
  final String successMessage;

  PatientAuthSuccess(this.successMessage);
}

final class PatientAuthError extends PatientAuthState {
  final String errorMessage;

  PatientAuthError(this.errorMessage);
}
