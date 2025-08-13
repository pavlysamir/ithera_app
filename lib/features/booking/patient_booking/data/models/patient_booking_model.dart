import 'package:equatable/equatable.dart';

class PatientBookingModel extends Equatable {
  final int id;
  final int doctorId;
  final int status;
  final String doctorName;
  final String? doctorImgURL;
  final String field;
  final String mobileNumber;
  final int gender;
  final bool anotherPatient;
  final List<PatientSessionModel> sessions;

  const PatientBookingModel({
    required this.id,
    required this.doctorId,
    required this.status,
    required this.doctorName,
    required this.field,
    required this.mobileNumber,
    required this.gender,
    required this.anotherPatient,
    required this.sessions,
    this.doctorImgURL,
  });

  factory PatientBookingModel.fromJson(Map<String, dynamic> json) {
    return PatientBookingModel(
      id: json['id'],
      doctorId: json['doctorId'],
      status: json['status'],
      doctorName: json['doctorName'],
      doctorImgURL: json['doctorImgURL'],
      field: json['field'],
      mobileNumber: json['mobileNumber'],
      gender: json['gender'],
      anotherPatient: json['anotherPatient'],
      sessions: (json['sessions'] as List)
          .map((e) => PatientSessionModel.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        doctorId,
        status,
        doctorName,
        doctorImgURL,
        field,
        mobileNumber,
        gender,
        anotherPatient,
        sessions,
      ];
}

class PatientSessionModel extends Equatable {
  final int sessionId;
  final int status;
  final String? cancelledBy;
  final String? date;
  final int scheduleId;
  final String startTime;
  final String endTime;
  final DateTime startDate;
  final int day;
  final String arabicDay;

  const PatientSessionModel({
    required this.sessionId,
    required this.status,
    this.cancelledBy,
    this.date,
    required this.scheduleId,
    required this.startTime,
    required this.endTime,
    required this.startDate,
    required this.day,
    required this.arabicDay,
  });

  factory PatientSessionModel.fromJson(Map<String, dynamic> json) {
    return PatientSessionModel(
      sessionId: json['sessionId'],
      status: json['status'],
      cancelledBy: json['cancelledBy']?.toString(),
      date: json['date'],
      scheduleId: json['scheduleId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      startDate: DateTime.parse(json['startDate']),
      day: json['day'],
      arabicDay: json['arabicDay'],
    );
  }

  @override
  List<Object?> get props => [
        sessionId,
        status,
        cancelledBy,
        date,
        scheduleId,
        startTime,
        endTime,
        startDate,
        day,
        arabicDay,
      ];
}
