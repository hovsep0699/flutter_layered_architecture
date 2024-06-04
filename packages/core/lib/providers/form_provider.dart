import 'package:flutter/cupertino.dart';

class FormProvider extends ChangeNotifier {
  bool _isValid = true;

  bool get isValid => _isValid;

  void updateTextFieldStatus(bool isValid) {
    _isValid = isValid;
    notifyListeners();
  }

  // bool validateUsername(String? username) {
  //   return username != null && username.length < 8;
  // }
  //
  // bool validatePassword(String? username) {
  //   return username != null && username.length < 8;
  // }
}
