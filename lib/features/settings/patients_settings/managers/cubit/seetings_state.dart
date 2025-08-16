part of 'seetings_cubit.dart';

@immutable
sealed class SeetingsState {}

final class SeetingsInitial extends SeetingsState {}

class SignOutSuccess extends SeetingsState {}

class PatientDataLoading extends SeetingsState {}

class PatientDataError extends SeetingsState {
  final String error;
  PatientDataError(this.error);
}

class PatientDataLoaded extends SeetingsState {
  final PatientData patientDataModel;
  PatientDataLoaded(this.patientDataModel);
}

class DeleteUserLoading extends SeetingsState {}

class DeleteUserError extends SeetingsState {
  final String error;
  DeleteUserError(this.error);
}

class DeleteUserLoaded extends SeetingsState {
  final String message;
  DeleteUserLoaded(this.message);
}
