import 'package:equatable/equatable.dart';

class FilesResponse extends Equatable {
  final bool isSuccess;
  final int version;
  final String? message;
  final List<FileItem> responseData;
  final int? totalCount;
  final dynamic errors;

  const FilesResponse({
    required this.isSuccess,
    required this.version,
    this.message,
    required this.responseData,
    this.totalCount,
    this.errors,
  });

  factory FilesResponse.fromJson(Map<String, dynamic> json) {
    return FilesResponse(
      isSuccess: json['isSuccess'] as bool,
      version: json['version'] as int,
      message: json['message'] as String?,
      responseData: (json['responseData'] as List<dynamic>)
          .map((e) => FileItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int?,
      errors: json['errors'],
    );
  }

  @override
  List<Object?> get props =>
      [isSuccess, version, message, responseData, totalCount, errors];
}

class FileItem extends Equatable {
  final int fileTypetId;
  final String fileTypeName;
  final String url;
  final String fileName;
  final String? description;

  const FileItem({
    required this.fileTypetId,
    required this.fileTypeName,
    required this.url,
    required this.fileName,
    this.description,
  });

  factory FileItem.fromJson(Map<String, dynamic> json) {
    return FileItem(
      fileTypetId: json['fileTypetId'] as int,
      fileTypeName: json['fileTypeName'] as String,
      url: json['url'] as String,
      fileName: json['fileName'] as String,
      description: json['description'] as String?,
    );
  }

  @override
  List<Object?> get props =>
      [fileTypetId, fileTypeName, url, fileName, description];
}
