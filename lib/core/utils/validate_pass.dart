class Validator {
  bool validatorpass(String pass){
      RegExp regExp = RegExp(r'^[a-zA-Z0-9]{8}$');
    return regExp.hasMatch(pass);
  }
}