import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ithera_app/core/api/api_consumer.dart';
import 'package:ithera_app/core/api/end_ponits.dart';
import 'package:ithera_app/core/errors/exceptions.dart';

class AddFileRepo {
  final ApiConsumer api;
  AddFileRepo({required this.api});

  Future<Either<String, void>> addFile(
      {required int userId,
      required int fileRoleId,
      required List<int> dataType,
      required List<File> file}) async {
    try {
      // Create FormData
      FormData formData = FormData();

      formData.fields.add(MapEntry("UserId", userId.toString()));
      formData.fields.add(MapEntry("Role", fileRoleId.toString()));

      for (int i = 0; i < file.length; i++) {
        formData.fields
            .add(MapEntry("File[$i].fileTypeId", dataType[i].toString()));
        formData.files.add(
          MapEntry(
            "File[$i].file",
            await MultipartFile.fromFile(file[i].path,
                filename: file[i].path.split('/').last),
          ),
        );
      }

      // Sending the request
      final response = await api.post(EndPoint.addFile, data: formData);

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
