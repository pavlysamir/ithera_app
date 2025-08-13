class LoginData {
  final int id;
  final String userName;
  final String email;
  final int role;
  final String token;
  final int? cityId; // ← خليه nullable

  LoginData({
    required this.id,
    required this.userName,
    required this.email,
    required this.role,
    required this.token,
    this.cityId, // ← مش required
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
      cityId: json.containsKey('cityId') ? json['cityId'] : null, // ← check
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'role': role,
      'token': token,
      if (cityId != null) 'cityId': cityId, // ← send only if not null
    };
  }
}
