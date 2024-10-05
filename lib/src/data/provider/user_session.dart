import 'package:flutter/material.dart';

class UserSessionEvent with ChangeNotifier {
  // static bool quack = true;
  static int? id;
  static String? name;
  static String? email;
  static int? role;

  // bool get quackValue => quack;
  int? get idValue => id;
  String? get nameValue => name;
  String? get emailValue => email;
  int? get roleValue => role;

  set value(dynamic newValue) {
    // quack = newValue;
    id = newValue;
    name = newValue;
    email = newValue;
    role = newValue;

    notifyListeners();
  }
}
