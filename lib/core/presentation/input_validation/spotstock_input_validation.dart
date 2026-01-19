import '../../constants/strings/spotstock_strings.dart';

mixin SpotstockInputValidationMixin {
  String? isValidEmail(String? email) {
    if (email == null || email.isEmpty) {
      return SpotstockStrings.emailIsRequired;
    }

    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      return SpotstockStrings.invalidEmail;
    }
    return null;
  }

  String? isValidPassword(String? password) {
    if (password == null || password.isEmpty) {
      return SpotstockStrings.passwordIsRequired;
    }
    return null;
  }
}
