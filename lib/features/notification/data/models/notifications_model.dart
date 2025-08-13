import 'package:equatable/equatable.dart';

class NotificationsResponse extends Equatable {
  final bool isSuccess;
  final int version;
  final String message;
  final List<NotificationItem> responseData;
  final dynamic errors;

  const NotificationsResponse({
    required this.isSuccess,
    required this.version,
    required this.message,
    required this.responseData,
    this.errors,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      isSuccess: json['isSuccess'] as bool,
      version: json['version'] as int,
      message: json['message'] as String,
      responseData: (json['responseData'] as List<dynamic>)
          .map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'],
    );
  }

  @override
  List<Object?> get props =>
      [isSuccess, version, message, responseData, errors];
}

class NotificationItem extends Equatable {
  final int? id;
  final String? value;
  final int? doctorId;
  final int? patientId;
  final int? adminId;
  final bool? forAdmin;
  final DateTime? createdOn;
  final int? walletRequestId;

  const NotificationItem({
    this.id,
    this.value,
    this.doctorId,
    this.patientId,
    this.adminId,
    this.forAdmin,
    this.createdOn,
    this.walletRequestId,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'] as int?,
      value: json['value'] as String?,
      doctorId: json['doctorId'] as int?,
      patientId: json['patientId'] as int?,
      adminId: json['adminId'] as int?,
      forAdmin: json['forAdmin'] as bool?,
      createdOn: DateTime.parse(json['createdOn'] as String),
      walletRequestId: json['walletRequestId'] as int?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        value,
        doctorId,
        patientId,
        adminId,
        forAdmin,
        createdOn,
        walletRequestId,
      ];
}
