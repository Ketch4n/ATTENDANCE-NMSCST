// controllers.dart
import 'package:flutter/material.dart';

class InstanceTextEditing {
  // Singleton pattern to ensure a single instance
  static final InstanceTextEditing _instance = InstanceTextEditing._internal();

  factory InstanceTextEditing() => _instance;

  InstanceTextEditing._internal();

  // Publicly accessible TextEditingController
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  // Dispose method to clean up resources
  void dispose() {
    email.dispose();
    pass.dispose();
  }
}
