abstract class AuthRepo {
  Future<void> login(String mobileNumber, String password, int roleId);
  Future<void> register(
    String email,
    String mobileNumber,
    String userName,
    String password,
    int cityId,
    int regionId,
    int genderId,
  );
  Future<void> logout();
}
