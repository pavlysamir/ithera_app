part of 'doctor_auth_cubit.dart';

@immutable
sealed class DoctorAuthState {}

final class DoctorAuthInitial extends DoctorAuthState {}

final class SuccessfulPickImage extends DoctorAuthState {}

final class FailPickImage extends DoctorAuthState {}
