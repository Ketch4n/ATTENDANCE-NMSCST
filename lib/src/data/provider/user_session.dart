import 'package:flutter/material.dart';

class UserSessionEvent with ChangeNotifier {
  static bool quack = true;
  bool get quackNew => quack;

  static int id = 0;
  static String name = "Undefined User";
  static String email = "email.undefined@gmail.com";
  static int role = 0;

  int? get idValue => id;
  String? get nameValue => name;
  String? get emailValue => email;
  int? get roleValue => role;

  set value(dynamic newValue) {
    quack = newValue;

    id = newValue;
    name = newValue;
    email = newValue;
    role = newValue;

    notifyListeners();
  }
}
