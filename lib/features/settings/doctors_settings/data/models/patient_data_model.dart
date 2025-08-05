import 'package:equatable/equatable.dart';

class PatientDataResponse extends Equatable {
  final bool isSuccess;
  final int version;
  final String? message;
  final PatientData? responseData;
  final dynamic errors;

  const PatientDataResponse({
    required this.isSuccess,
    required this.version,
    this.message,
    this.responseData,
    this.errors,
  });

  factory PatientDataResponse.fromJson(Map<String, dynamic> json) {
    return PatientDataResponse(
      isSuccess: json['isSuccess'],
      version: json['version'],
      message: json['message'],
      responseData: json['responseData'] != null
          ? PatientData.fromJson(json['responseData'])
          : null,
      errors: json['errors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
      'version': version,
      'message': message,
      'responseData': responseData?.toJson(),
      'errors': errors,
    };
  }

  @override
  List<Object?> get props => [
        isSuccess,
        version,
        message,
        responseData,
        errors,
      ];
}

class PatientData extends Equatable {
  final int id;
  final String name;
  final String? mobileNumber;
  final String email;
  final int cityId;
  final String cityName;
  final int regionId;
  final String regionName;
  final int gender;

  const PatientData({
    required this.id,
    required this.name,
    this.mobileNumber,
    required this.email,
    required this.cityId,
    required this.cityName,
    required this.regionId,
    required this.regionName,
    required this.gender,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) {
    return PatientData(
      id: json['id'],
      name: json['name'],
      mobileNumber: json['mobileNumber'],
      email: json['email'],
      cityId: json['cityId'],
      cityName: json['cityName'],
      regionId: json['regionId'],
      regionName: json['regionName'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobileNumber': mobileNumber,
      'email': email,
      'cityId': cityId,
      'cityName': cityName,
      'regionId': regionId,
      'regionName': regionName,
      'gender': gender,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        mobileNumber,
        email,
        cityId,
        cityName,
        regionId,
        regionName,
        gender,
      ];
}
