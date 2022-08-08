enum Validator {
  phone, password;

  bool verify(String text) {
    switch (this) {
      case Validator.phone:
        RegExp exp = RegExp(
            r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
        return exp.hasMatch(text);
      case Validator.password:
        RegExp exp = RegExp(
            r'^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,}$');
        return exp.hasMatch(text);
    }
  }
}
