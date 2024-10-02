import 'package:flutter/material.dart';

class UserSessionEvent with ChangeNotifier {
  static bool quack = true;

  bool get quackNew => quack;

  set value(bool newValue) {
    quack = newValue;

    notifyListeners();
  }
}
