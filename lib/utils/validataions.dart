class Validations {
  static bool emailValidator(String email) {
    bool emailVaild = RegExp(r'').hasMatch(email);

    return emailVaild;
  }
}
