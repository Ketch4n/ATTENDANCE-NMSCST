// controllers.dart
import 'package:attendance_nmscst/src/data/constant/constant_text_controller.dart';
import 'package:flutter/material.dart';

class InstanceTextEditing {
  // Singleton pattern to ensure a single instance
  static final InstanceTextEditing _instance = InstanceTextEditing._internal();

  factory InstanceTextEditing() => _instance;

  InstanceTextEditing._internal();

  // Publicly accessible TextEditingController
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController body = TextEditingController();

  // Dispose method to clean up resources
  void dispose() {
    email.dispose();
    pass.dispose();
    subject.dispose();
    body.dispose();
  }

  static void clear() {
    controller.email.clear();
    controller.pass.clear();
    controller.subject.clear();
    controller.body.clear();
  }
}
