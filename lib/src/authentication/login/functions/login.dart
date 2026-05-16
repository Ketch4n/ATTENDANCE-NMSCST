import 'dart:convert';

import 'package:attendance_nmscst/src/components/circular_loading.dart';
import 'package:attendance_nmscst/src/components/snackbar.dart';
import 'package:attendance_nmscst/src/data/constant/constant_text_controller.dart';
import 'package:attendance_nmscst/src/data/provider/demo_mode_provider.dart';
import 'package:attendance_nmscst/src/data/provider/user_session.dart';
import 'package:attendance_nmscst/src/data/server/url.dart';
import 'package:attendance_nmscst/src/pages/index/index_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> login(context) async {
  final email = controller.email.text.trim();
  final password = controller.pass.text.trim();

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    customSnackBar(context, 1, "Username or Password Empty!");
    return;
  }

  // In demo mode, use mock credentials
  final isDemoMode =
      Provider.of<DemoModeProvider>(context, listen: false).isDemoMode;

  if (isDemoMode) {
    await _loginDemoMode(context, email, password);
    return;
  }

  circularLoading(context);
  try {
    final response = await http.post(
      Uri.parse("${Servername.host}admin/login"),
      body: {
        'email': email,
        'password': password,
      },
    ).timeout(const Duration(seconds: 10));

    Map<String, dynamic> jsonResponse = json.decode(response.body);

    bool quack = jsonResponse['quack'];
    var user = jsonResponse['user'];
    var message = jsonResponse['message'];

    if (response.statusCode == 200 && quack) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userID', user['id']);
      await prefs.setString('userNAME', user['name']);
      await prefs.setString('userEMAIL', user['email']);
      await prefs.setInt('userROLE', user['role']);

      UserSessionEvent.id = user['id'];
      UserSessionEvent.email = user['email'];
      UserSessionEvent.name = user['name'];
      UserSessionEvent.role = user['role'];

      customSnackBar(context, 0, message);

      // ignore: use_build_context_synchronously
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const IndexPage()),
      );
    } else {
      // ignore: use_build_context_synchronously
      customSnackBar(context, 1, message);
    }
  } catch (e) {
    // ignore: use_build_context_synchronously
    customSnackBar(
        context, 1, "Cannot connect to server. Check your connection.");
  } finally {
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}

/// Demo mode login — accepts any non-empty credentials
Future<void> _loginDemoMode(context, String email, String password) async {
  circularLoading(context);

  // Simulate network delay
  await Future.delayed(const Duration(milliseconds: 800));

  // Mock user session
  UserSessionEvent.id = 1;
  UserSessionEvent.email = email;
  UserSessionEvent.name = 'Demo User';
  UserSessionEvent.role = 1;

  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('userID', 1);
  await prefs.setString('userNAME', 'Demo User');
  await prefs.setString('userEMAIL', email);
  await prefs.setInt('userROLE', 1);

  // ignore: use_build_context_synchronously
  Navigator.of(context).pop(); // close loading dialog first

  // ignore: use_build_context_synchronously
  customSnackBar(context, 0, "Logged in as Demo User");

  // ignore: use_build_context_synchronously
  await Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const IndexPage()),
  );
}
