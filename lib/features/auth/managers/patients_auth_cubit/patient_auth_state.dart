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

final class PatientLoginLoading extends PatientAuthState {}

final class PatientLoginSuccess extends PatientAuthState {
  final String successMessage;

  PatientLoginSuccess(this.successMessage);
}

final class PatientLoginError extends PatientAuthState {
  final String errorMessage;

  PatientLoginError(this.errorMessage);
}
