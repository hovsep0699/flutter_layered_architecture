class SignInService {
  static String? validateUsername(String? username) {
    if (username == null || username.length < 8) {
      return "required";
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.length < 8) {
      return "required";
    }
    return null;
  }
}
