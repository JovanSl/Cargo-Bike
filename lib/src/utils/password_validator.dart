import '../exceptions/password_exception.dart';

class PasswordValidator {
  PasswordException call(String password) {
    if (password.length < 8) {
      return PasswordException('Password must be at least 8 characters');
    } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(password)) {
      return PasswordException(
          'Password should contain at least one uppercase letter');
    } else if (!RegExp(r'(?=.*?[0-9])').hasMatch(password)) {
      return PasswordException('Password should contain at least one number');
    } else if (!RegExp(r'(?=.*?[!"#$%&' r"'()*+,-./:;<=>?@[\]\\^_`{|}~])")
        .hasMatch(password)) {
      return PasswordException(
          'Password should contain at least one special character');
    } else {
      return PasswordException('');
    }
  }
}
