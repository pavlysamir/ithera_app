part of 'seetings_cubit.dart';

@immutable
sealed class SeetingsState {}

final class SeetingsInitial extends SeetingsState {}

class SignOutSuccess extends SeetingsState {}
