class EndPoint {
  static String baseUrl = "http://ithera-001-site1.ptempurl.com/";

//auth endpoints
  static String login = "api/Auth/Login";

  static String patientRegister = "api/Auth/PatientRegister";

  static String doctorRegister = "api/Auth/DoctorRegister";

  static String getAllCities = "BaseLookup/GetAllCities";

  static String getAllRegions = "BaseLookup/GetAllRegions";

  static String getAllSpecialties = "BaseLookup/GetAllSpecializationFields";

  static String addFile = "File/AddFile";

  static String manageSchedules = "api/Doctor/manageSchedules";

  static String getAllDoctors = "api/Patient/GetAllDoctors";

  static String bookSession = "api/Patient/BookSession";

  static String getAllPatientBooking = "api/Patient/GetAllBookings";

  static String getDoctorDataEndPoint(id) {
    return "api/Doctor/$id";
  }

  static String deleteDoctorSchedule(doctorId, regionId, scheduleId) {
    return "api/Doctor/$doctorId/$regionId/$scheduleId";
  }
}

class ApiKey {
  static String status = "statusCode";
  static String errorMessage = "message";
  static String errors = "errors";
  static String email = "email";
  static String password = "password";
  static String userName = "userName";
  static String phoneNumber = "phoneNumber";
  static String cityId = "cityId";
  static String regionId = "regionId";
  static String anotherMobileNumber = "anotherMobileNumber";
  static String gender = "gender";
  static String dateOfBirth = "dateOfBirth";

  static String userId = "UserId";

  static String specializationFieldIds = "specializationFieldIds";

  static String role = "role";

  static String fileRole = "Role";

  static String file = "File";

  static String contantType = "Content-Type";
}
