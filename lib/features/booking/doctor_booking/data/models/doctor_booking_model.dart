import 'package:equatable/equatable.dart';
import 'package:ithera_app/features/booking/patient_booking/data/models/patient_booking_model.dart';

class DoctorBookingModel extends Equatable {
  final int id;
  final int patientId;
  final int status;
  final String address;
  final String patientName;
  final String? doctorImgURL;
  final String field;
  final String mobileNumber;
  final int gender;
  final bool anotherPatient;
  final List<PatientSessionModel> sessions;

  const DoctorBookingModel({
    required this.id,
    required this.patientId,
    required this.status,
    required this.address,
    required this.patientName,
    required this.field,
    required this.mobileNumber,
    required this.gender,
    required this.anotherPatient,
    required this.sessions,
    this.doctorImgURL,
  });

  factory DoctorBookingModel.fromJson(Map<String, dynamic> json) {
    return DoctorBookingModel(
      id: json['id'],
      patientId: json['patientId'],
      status: json['status'],
      address: json['address'] ?? '',
      patientName: json['patientName'] ?? '',
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
  String get arabicDaysLine {
    final uniqueDays =
        sessions.map((session) => session.arabicDay).toSet().toList();
    return uniqueDays.join(' - ');
  }

  @override
  List<Object?> get props => [
        id,
        patientId,
        status,
        patientName,
        doctorImgURL,
        field,
        mobileNumber,
        gender,
        anotherPatient,
        sessions,
      ];
}
