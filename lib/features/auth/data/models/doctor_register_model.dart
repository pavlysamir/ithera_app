class DoctorRegisterModel {
  final String email;
  final String userName;
  final String? password;
  final String phoneNumber;
  final int cityId;
  final int regionId;
  final int gender;
  final DateTime dateOfBirth;

  DoctorRegisterModel({
    required this.email,
    required this.userName,
    this.password,
    required this.phoneNumber,
    required this.cityId,
    required this.regionId,
    required this.gender,
    required this.dateOfBirth,
  });

  factory DoctorRegisterModel.fromJson(Map<String, dynamic> json) {
    return DoctorRegisterModel(
      email: json['email'],
      userName: json['userName'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      cityId: json['cityId'],
      regionId: json['regionId'],
      gender: json['gender'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userName': userName,
      'password': password,
      'phoneNumber': phoneNumber,
      'cityId': cityId,
      'regionId': regionId,
      'gender': gender,
      'dateOfBirth': dateOfBirth.toIso8601String(),
    };
  }
}
