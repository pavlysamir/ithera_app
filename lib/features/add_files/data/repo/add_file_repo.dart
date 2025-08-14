import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ithera_app/core/api/api_consumer.dart';
import 'package:ithera_app/core/api/end_ponits.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/errors/exceptions.dart';
import 'package:ithera_app/features/add_files/data/models/get_file_model.dart';

class AddFileRepo {
  final ApiConsumer api;
  AddFileRepo({required this.api});

  // Issue 1: Missing Authorization Header
// You commented out the Authorization header - this might be required

  Future<Either<String, void>> addFile(
      {required List<String> dataType,
      required List<File> file,
      required int rileId}) async {
    try {
      // Create FormData
      FormData formData = FormData();

      // Add userId field
      formData.fields.add(MapEntry("file.userid",
          CacheHelper.getInt(key: CacheConstants.userId).toString()));

      formData.fields.add(MapEntry("file.role", rileId.toString()));

      // Add files and their types
      for (int i = 0; i < file.length; i++) {
        formData.fields.add(MapEntry("file.file[$i].fileTypeId", dataType[i]));
        formData.files.add(
          MapEntry(
            "file.file[$i].file",
            await MultipartFile.fromFile(file[i].path,
                filename: file[i].path.split('/').last),
          ),
        );
      }

      // Sending the request
      final response = await Dio().post(
          'http://ithera-001-site1.ptempurl.com/File/AddFile',
          data: formData);

      // Check the response and return accordingly
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return const Left('Failed to upload files');
      }
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? '');
    } catch (e) {
      return const Left('An unexpected error occurred');
    }
  }

  Future<Either<String, FilesResponse>> getFile(
      {required int fileId, required int role}) async {
    try {
      final response = await api.post(
        EndPoint.getFile,
        queryParameters: {
          'filetypeId': fileId,
          'userId': CacheHelper.getInt(key: CacheConstants.userId),
          'role': role
        },
      );

      FilesResponse filesResponse = FilesResponse.fromJson(response);

      if (fileId == 3 && filesResponse.responseData.isNotEmpty) {
        CacheHelper.set(
            key: CacheConstants.userImage,
            value: filesResponse.responseData.last.url);
      }

      return Right(filesResponse);
    } on ServerException catch (e) {
      return Left(e.errModel?.errorMessage ?? '');
    }
  }
}
