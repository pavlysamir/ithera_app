import 'package:equatable/equatable.dart';

class BookingDetailsResponse extends Equatable {
  final bool isSuccess;
  final int version;
  final String message;
  final BookingDetailsData responseData;
  final dynamic errors;

  const BookingDetailsResponse({
    required this.isSuccess,
    required this.version,
    required this.message,
    required this.responseData,
    this.errors,
  });

  factory BookingDetailsResponse.fromJson(Map<String, dynamic> json) {
    return BookingDetailsResponse(
      isSuccess: json['isSuccess'] as bool,
      version: json['version'] as int,
      message: json['message'] as String,
      responseData: BookingDetailsData.fromJson(
          json['responseData'] as Map<String, dynamic>),
      errors: json['errors'],
    );
  }

  @override
  List<Object?> get props =>
      [isSuccess, version, message, responseData, errors];
}

class BookingDetailsData extends Equatable {
  final int id;
  final String? reportURL;
  final String? xRayURL;
  final String address;
  final String patientName;
  final String? description;
  final String mobileNumber;
  final int gender;
  final bool anotherPatient;
  final int patientId;
  final String? anotherPatientName;
  final String anotherPatientPhoneNumber;
  final int? age;
  final String? typeOfKinShip;
  final String diagnosisess;
  final String? symptoms;
  final List<RegionSchedule> regionSchedules;

  const BookingDetailsData({
    required this.id,
    this.reportURL,
    this.xRayURL,
    required this.address,
    required this.patientName,
    this.description,
    required this.mobileNumber,
    required this.gender,
    required this.anotherPatient,
    required this.patientId,
    this.anotherPatientName,
    required this.anotherPatientPhoneNumber,
    this.age,
    this.typeOfKinShip,
    required this.diagnosisess,
    this.symptoms,
    required this.regionSchedules,
  });

  factory BookingDetailsData.fromJson(Map<String, dynamic> json) {
    return BookingDetailsData(
      id: json['id'] as int,
      reportURL: json['reportURL'] as String?,
      xRayURL: json['x_RayURL'] as String?,
      address: json['address'] as String,
      patientName: json['patientName'] as String,
      description: json['description'] as String?,
      mobileNumber: json['mobileNumber'] as String,
      gender: json['gender'] as int,
      anotherPatient: json['anotherPatient'] as bool,
      patientId: json['patientId'] as int,
      anotherPatientName: json['anotherPatientName'] as String?,
      anotherPatientPhoneNumber: json['anotherPatientPhoneNumber'] as String,
      age: json['age'] as int?,
      typeOfKinShip: json['typeOfKinShip'] as String?,
      diagnosisess: json['diagnosisess'] as String,
      symptoms: json['symptoms'] as String?,
      regionSchedules: (json['regionSchedules'] as List<dynamic>)
          .map((e) => RegionSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        reportURL,
        xRayURL,
        address,
        patientName,
        description,
        mobileNumber,
        gender,
        anotherPatient,
        patientId,
        anotherPatientName,
        anotherPatientPhoneNumber,
        age,
        typeOfKinShip,
        diagnosisess,
        symptoms,
        regionSchedules,
      ];
}

class RegionSchedule extends Equatable {
  final int regionId;
  final int cardId;
  final String regionName;
  final double sessionPrice;
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
      regionId: json['regionId'] as int,
      cardId: json['cardId'] as int,
      regionName: json['regionName'] as String,
      sessionPrice: json['sessionPrice'] as double,
      days: (json['days'] as List<dynamic>).cast<String>(),
      schedules: (json['schedules'] as List<dynamic>)
          .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
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
      scheduleId: json['scheduleId'] as int,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
    );
  }

  @override
  List<Object?> get props => [scheduleId, startTime, endTime, startDate];
}
