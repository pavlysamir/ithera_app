import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/features/add_files/data/repo/add_file_repo.dart';
import 'package:meta/meta.dart';

part 'add_files_state.dart';

class AddFilesCubit extends Cubit<AddFilesState> {
  AddFilesCubit(
    this._addFileRepo,
  ) : super(AddFilesInitial());

  final AddFileRepo _addFileRepo;

  static AddFilesCubit get(context) => BlocProvider.of(context);

  Future<void> addFile(
      {List<File>? files, List<String>? fileType, required int rileId}) async {
    emit(AddFileLoading());
    final response = await _addFileRepo.addFile(
      dataType: fileType!,
      file: files!,
      rileId: rileId,
    );

    response.fold(
      (errMessage) => emit(AddFileFaluir(errMessage)),
      (message) {
        emit(AddFileSuccess());
      },
    );
  }

  Future<void> getFile({required int fileId, required int roleId}) async {
    emit(AddFileLoading());
    final response = await _addFileRepo.getFile(fileId: fileId, role: roleId);

    response.fold(
      (errMessage) => emit(AddFileFaluir(errMessage)),
      (message) {
        emit(AddFileSuccess());
      },
    );
  }
}
