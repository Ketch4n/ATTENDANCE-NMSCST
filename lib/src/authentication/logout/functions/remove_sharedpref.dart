import 'package:attendance_nmscst/src/authentication/auth/auth_index.dart';
import 'package:attendance_nmscst/src/data/instance/instance_text_controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void removeSharedPref(context) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('userID');
  prefs.remove('userNAME');
  prefs.remove('userEMAIL');
  prefs.remove('userROLE');

  Navigator.of(context)
      .pushReplacement(
    MaterialPageRoute(
      builder: (context) => const AuthIndex(),
    ),
  )
      .whenComplete(() {
    InstanceTextEditing.clear();
  });
}
