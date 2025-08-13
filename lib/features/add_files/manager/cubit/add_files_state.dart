part of 'add_files_cubit.dart';

@immutable
sealed class AddFilesState {}

final class AddFilesInitial extends AddFilesState {}

final class AddFileLoading extends AddFilesState {}

final class AddFileFaluir extends AddFilesState {
  final String errorMessage;

  AddFileFaluir(this.errorMessage);
}

final class AddFileSuccess extends AddFilesState {}
