import 'package:flutter/material.dart';

class IndexedStackPagesEvent with ChangeNotifier {
  static int quack = 0;

  int get quackNew => quack;

  set value(int newValue) {
    quack = newValue;

    notifyListeners();
  }
}
