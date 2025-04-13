class LoginData {
  final int id;
  final String userName;
  final String email;
  final int role;
  final String token;

  LoginData({
    required this.id,
    required this.userName,
    required this.email,
    required this.role,
    required this.token,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'role': role,
      'token': token,
    };
  }
}
