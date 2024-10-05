import 'dart:convert';

import 'package:attendance_nmscst/src/components/circular_loading.dart';
import 'package:attendance_nmscst/src/components/snackbar.dart';
import 'package:attendance_nmscst/src/data/constant/constant_text_controller.dart';
import 'package:attendance_nmscst/src/data/provider/user_session.dart';
import 'package:attendance_nmscst/src/data/server/url.dart';
import 'package:attendance_nmscst/src/pages/index/index_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> login(context) async {
  final email = controller.email.text.trim();
  final password = controller.pass.text.trim();
  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    customSnackBar(context, 1, "Username or Password Empty!");
    return;
  } else {
    circularLoading(context);
    try {
      final prefs = await SharedPreferences.getInstance();
      final response = await http.post(
        Uri.parse("${Servername.host}admin/login"),
        body: {
          'email': email,
          'password': password,
        },
      );
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      bool quack = jsonResponse['quack'];
      var user = jsonResponse['user'];
      var message = jsonResponse['message'];

      if (response.statusCode == 200 && quack) {
        await prefs.setInt('userID', user['id']);
        await prefs.setString('userNAME', user['name']);
        await prefs.setString('userEMAIL', user['email']);
        await prefs.setInt('userROLE', user['role']);

        UserSessionEvent.id = user['id'];
        UserSessionEvent.email = user['email'];
        UserSessionEvent.name = user['name'];
        UserSessionEvent.role = user['role'];

        customSnackBar(context, 0, message);

        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const IndexPage(),
          ),
        );
      } else {
        customSnackBar(context, 1, message);
      }
    } catch (e) {
      print(e);
    } finally {
      Navigator.of(context).pop();
    }
  }
}
