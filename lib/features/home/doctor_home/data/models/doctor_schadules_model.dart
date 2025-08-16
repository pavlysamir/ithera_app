import 'package:equatable/equatable.dart';

class DoctorScheduleResponse extends Equatable {
  final bool isSuccess;
  final int version;
  final String message;
  final DoctorResponseData responseData;
  final dynamic errors;

  const DoctorScheduleResponse({
    required this.isSuccess,
    required this.version,
    required this.message,
    required this.responseData,
    this.errors,
  });

  factory DoctorScheduleResponse.fromJson(Map<String, dynamic> json) {
    return DoctorScheduleResponse(
      isSuccess: json['isSuccess'],
      version: json['version'],
      message: json['message'],
      responseData: DoctorResponseData.fromJson(json['responseData']),
      errors: json['errors'],
    );
  }

  @override
  List<Object?> get props =>
      [isSuccess, version, message, responseData, errors];
}

class DoctorResponseData extends Equatable {
  final String doctorName;
  final int doctorId;
  final int cityId;
  final int gender;
  final List<SpecializationField> specializationFields;
  final num? sessionPrice;
  final double averageRating;
  final String? profilePicture;
  final List<RegionSchedule> regionSchedules;
  final List<int> doctorSessionsIds;
  final String? description;
  final String? phoneNumber;
  final String? anotherMobileNumber;
  final String? email;
  final String? idImageURL;

  const DoctorResponseData(
      {required this.doctorName,
      required this.doctorId,
      required this.cityId,
      required this.gender,
      required this.specializationFields,
      required this.sessionPrice,
      required this.averageRating,
      required this.profilePicture,
      required this.regionSchedules,
      required this.doctorSessionsIds,
      this.description,
      this.phoneNumber,
      this.anotherMobileNumber,
      this.email,
      this.idImageURL});

  factory DoctorResponseData.fromJson(Map<String, dynamic> json) {
    return DoctorResponseData(
      doctorName: json['doctorName'],
      doctorId: json['doctorId'],
      cityId: json['cityId'],
      gender: json['gender'],
      specializationFields: (json['specializationFields'] as List)
          .map((e) => SpecializationField.fromJson(e))
          .toList(),
      sessionPrice: json['sessionPrice'],
      averageRating: (json['averageRating'] as num).toDouble(),
      profilePicture: json['profilePicture'],
      regionSchedules: (json['regionSchedules'] as List)
          .map((e) => RegionSchedule.fromJson(e))
          .toList(),
      doctorSessionsIds: List<int>.from(json['doctorSessionsIds']),
      description: json['description'],
      phoneNumber: json['phoneNumber'],
      anotherMobileNumber: json['anotherMobileNumber'],
      email: json['email'],
      idImageURL: json['idImageURL'],
    );
  }

  @override
  List<Object?> get props => [
        doctorName,
        doctorId,
        cityId,
        gender,
        specializationFields,
        sessionPrice,
        averageRating,
        profilePicture,
        regionSchedules,
        doctorSessionsIds,
        description,
        phoneNumber,
        anotherMobileNumber,
        email,
        idImageURL
      ];
}

class SpecializationField extends Equatable {
  final int id;
  final String nameEn;
  final String nameAr;

  const SpecializationField({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });

  factory SpecializationField.fromJson(Map<String, dynamic> json) {
    return SpecializationField(
      id: json['id'],
      nameEn: json['nameEn'],
      nameAr: json['nameAr'],
    );
  }

  @override
  List<Object?> get props => [id, nameEn, nameAr];
}

class RegionSchedule extends Equatable {
  final int regionId;
  final int cardId;
  final String regionName;
  final num sessionPrice;
  final List<String> days;
  final List<Schedule> schedules;

  const RegionSchedule({
    required this.regionId,
    required this.cardId,
    required this.regionName,
    required this.sessionPrice,
    required this.days,
    required this.schedules,
  });

  factory RegionSchedule.fromJson(Map<String, dynamic> json) {
    return RegionSchedule(
      regionId: json['regionId'],
      cardId: json['cardId'],
      regionName: json['regionName'],
      sessionPrice: json['sessionPrice'],
      days: List<String>.from(json['days']),
      schedules:
          (json['schedules'] as List).map((e) => Schedule.fromJson(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [
        regionId,
        cardId,
        regionName,
        sessionPrice,
        days,
        schedules,
      ];
}

class Schedule extends Equatable {
  final int scheduleId;
  final String startTime;
  final String endTime;
  final DateTime startDate;

  const Schedule({
    required this.scheduleId,
    required this.startTime,
    required this.endTime,
    required this.startDate,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      scheduleId: json['scheduleId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      startDate: DateTime.parse(json['startDate']),
    );
  }

  @override
  List<Object?> get props => [scheduleId, startTime, endTime, startDate];
}
