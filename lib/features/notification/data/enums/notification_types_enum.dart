enum NotificationType {
  requestJoinDoctor,
  depositeRequestForAdmin,
  depositeRequestForDoctor,
  withDrawalRequest,
  patientBookingRequestForDoctor,
  activeDoctorAccount,
  activePatientAccount,
  inActivePatientAccount,
  inActiveDoctorAccount,
  freezeMoney,
  sessionCancelationForDoctor,
  sessionCancelationForPatient,
  bookingConfirmed,
  bookingCancelation,
}

extension NotificationTypeExtension on NotificationType {
  /// Convert enum → int (index starting from 0)
  int get toInt => NotificationType.values.indexOf(this);

  /// Convert int → enum
  static NotificationType fromInt(int index) {
    if (index < 0 || index >= NotificationType.values.length) {
      throw ArgumentError('Invalid notification type index: $index');
    }
    return NotificationType.values[index];
  }
}
