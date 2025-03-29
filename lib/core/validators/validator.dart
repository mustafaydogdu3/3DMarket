class Validator {
  static String? email(String? input) {
    if (input != null && input.isNotEmpty) {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(input)) {
        return null;
      } else {
        return "Invalid email!";
      }
    }

    return "Cannot be left blank!";
  }

  static String? password(
    String? input, {
    String? repeatPassword,
  }) {
    if (input == null || input.isEmpty) {
      return "Cannot be left blank!";
    }

    if (input.length < 6) {
      return "Password must be at least 6 characters!";
    }

    if (repeatPassword != null) {
      if (input != repeatPassword) {
        return "Passwords do not match!";
      }
    }

    return null;
  }

  static String? repeatPassword(String? input, String password) {
    if (input == null || input.isEmpty) {
      return "Cannot be left blank!";
    }

    if (input.length < 6) {
      return "Password must be at least 6 characters!";
    }

    if (input != password) {
      return "Passwords do not match!";
    }

    return null;
  }

  static String? stringInput(String? input) {
    if (input == null || input.isEmpty) {
      return "Cannot be left blank!";
    }
    return null;
  }

  static String? phone(String? input) {
    if (input != null && input.isNotEmpty) {
      if (RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(input)) {
        return null;
      } else {
        return "Invalid phone number";
      }
    }
    return "Cannot be left blank!";
  }

  static String? zipCode(String? input) {
    if (input == null || input.isEmpty) {
      return "Cannot be left blank!";
    }

    if (!RegExp(r'^[0-9]{4,10}$').hasMatch(input)) {
      return "Invalid postal code!";
    }

    return null;
  }
}
