import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ithera_app/core/api/api_consumer.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/errors/exceptions.dart';

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
}
