import 'package:flutter/material.dart';

class DemoModeProvider with ChangeNotifier {
  bool _isDemoMode = false;
  bool _hasCheckedConnectivity = false;

  bool get isDemoMode => _isDemoMode;
  bool get hasCheckedConnectivity => _hasCheckedConnectivity;

  void enableDemoMode() {
    _isDemoMode = true;
    _hasCheckedConnectivity = true;
    notifyListeners();
  }

  void disableDemoMode() {
    _isDemoMode = false;
    notifyListeners();
  }

  void setConnectivityChecked() {
    _hasCheckedConnectivity = true;
    notifyListeners();
  }

  void reset() {
    _isDemoMode = false;
    _hasCheckedConnectivity = false;
    notifyListeners();
  }
}
