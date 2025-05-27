import 'package:equatable/equatable.dart';

class DoctorModelResponse extends Equatable {
  final int pageIndex;
  final int pageSize;
  final int count;
  final List<DoctorModel> items;

  const DoctorModelResponse({
    required this.pageIndex,
    required this.pageSize,
    required this.count,
    required this.items,
  });

  factory DoctorModelResponse.fromJson(Map<String, dynamic> json) {
    return DoctorModelResponse(
      pageIndex: json['pageIndex'],
      pageSize: json['pageSize'],
      count: json['count'],
      items: List<DoctorModel>.from(
        json['items'].map((item) => DoctorModel.fromJson(item)),
      ),
    );
  }

  @override
  List<Object?> get props => [pageIndex, pageSize, count, items];
}

class DoctorModel extends Equatable {
  final String doctorName;
  final int doctorId;
  final int cityId;
  final bool? gender;
  final List<SpecializationField> specializationFields;
  final num? sessionPrice;
  final double averageRating;
  final String? profilePicture;
  final List<DoctorRegionSchedule>? regionSchedules;
  final List<dynamic> doctorSessionsIds;

  const DoctorModel({
    required this.doctorName,
    required this.doctorId,
    required this.cityId,
    required this.gender,
    required this.specializationFields,
    required this.sessionPrice,
    required this.averageRating,
    required this.profilePicture,
    required this.regionSchedules,
    required this.doctorSessionsIds,
  });
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      doctorName: json['doctorName'],
      doctorId: json['doctorId'],
      cityId: json['cityId'],
      gender: json['gender'] is bool ? json['gender'] as bool : null,
      specializationFields: List<SpecializationField>.from(
        json['specializationFields']
            .map((e) => SpecializationField.fromJson(e)),
      ),
      sessionPrice: (json['sessionPrice'] as num?)?.toDouble() ?? 0.0,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      profilePicture: json['profilePicture'],
      regionSchedules: json['regionSchedules'] != null
          ? List<DoctorRegionSchedule>.from(
              json['regionSchedules']
                  .map((e) => DoctorRegionSchedule.fromJson(e)),
            )
          : [],
      doctorSessionsIds: json['doctorSessionsIds'] ?? [],
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

class DoctorRegionSchedule extends Equatable {
  final int regionId;
  final int cardId;
  final String regionName;
  final num sessionPrice;
  final List<String> days;
  final List<Schedule> schedules;

  const DoctorRegionSchedule({
    required this.regionId,
    required this.cardId,
    required this.regionName,
    required this.sessionPrice,
    required this.days,
    required this.schedules,
  });

  factory DoctorRegionSchedule.fromJson(Map<String, dynamic> json) {
    return DoctorRegionSchedule(
      regionId: json['regionId'],
      cardId: json['cardId'],
      regionName: json['regionName'],
      sessionPrice: json['sessionPrice'],
      days: List<String>.from(json['days']),
      schedules:
          (json['schedules'] as List).map((e) => Schedule.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'regionId': regionId,
      'cardId': cardId,
      'regionName': regionName,
      'sessionPrice': sessionPrice,
      'days': days,
      'schedules': schedules.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props =>
      [regionId, cardId, regionName, sessionPrice, days, schedules];
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

  Map<String, dynamic> toJson() {
    return {
      'scheduleId': scheduleId,
      'startTime': startTime,
      'endTime': endTime,
      'startDate': startDate.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [scheduleId, startTime, endTime, startDate];
}
