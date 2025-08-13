class BookingRequest {
  final int patientId;
  final int doctorId;
  final int cardId;
  final String? patientName;
  final int? gender;
  final String? anotherPatientPhoneNumber;
  final bool? anotherPatient;
  final int? age;
  final String? address;
  final String? diagnosiss;

  BookingRequest({
    required this.patientId,
    required this.doctorId,
    required this.cardId,
    this.patientName,
    this.gender,
    this.anotherPatientPhoneNumber,
    this.anotherPatient,
    this.age,
    this.address,
    this.diagnosiss,
  });

  Map<String, dynamic> toJson() {
    return {
      "patientId": patientId,
      "doctorId": doctorId,
      "cardId": cardId,
      if (patientName != null) "patientName": patientName,
      if (gender != null) "gender": gender,
      if (anotherPatientPhoneNumber != null)
        "anotherPatientPhoneNumber": anotherPatientPhoneNumber,
      if (anotherPatient != null) "anotherPatient": anotherPatient,
      if (age != null) "age": age,
      if (address != null) "address": address,
      if (diagnosiss != null) "diagnosisess": diagnosiss,
    };
  }
}
