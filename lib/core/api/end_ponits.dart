class EndPoint {
  static String baseUrl = "http://ithera-001-site1.ptempurl.com/";

//auth endpoints
  static String login = "api/Auth/Login";

  static String patientRegister = "api/Auth/PatientRegister";

  static String doctorRegister = "api/Auth/DoctorRegister";

  static String getAllCities = "BaseLookup/GetAllCities";

  static String getAllRegions = "BaseLookup/GetAllRegions";

  static String getUserDataEndPoint(id) {
    return "/User/$id";
  }
}

class ApiKey {
  static String status = "statusCode";
  static String errorMessage = "message";
  static String errors = "errors";
  static String email = "email";
  static String password = "password";
  static String mobNumber = "mobileNumber";
  static String referCode = "referCode";

  static String specialization = "specialization";

  static String otp = "OTP";
  static String newForgetPassword = "newPass";
  static String token = "token";

  static String id = "id";
  static String firstName = "firstName";
  static String userName = "userName";

  static String address = "address";

  static String kedId = "kedId";
  static String keNumber = "kedNumber";

  static String phone = "phone";
  static String confirmPassword = "confirmPassword";
  static String location = "location";
  static String profilePic = "profileImage";
  static String authorizationHeader = "Authorization";
  static String verfyAccount = "verfyAccount";
  static String oldPassword = "oldPassword";
  static String newPassword = "newPassword";
  static String resetPasswordNumber = "resetPasswordNumber";
  static String resetPasswordNumberOtp = "resetPasswordNumberOtp";

  static String contantType = "Content-Type";
}
