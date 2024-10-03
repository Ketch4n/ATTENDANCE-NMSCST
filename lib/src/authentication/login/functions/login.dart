import 'dart:convert';

import 'package:attendance_nmscst/src/components/snackbar.dart';
import 'package:attendance_nmscst/src/data/provider/user_session.dart';
import 'package:attendance_nmscst/src/data/server/url.dart';
import 'package:attendance_nmscst/src/pages/index/index_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void login(context, email, password) async {
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

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const IndexPage(),
        ),
      );
      customSnackBar(context, 0, message);
    } else {
      customSnackBar(context, 1, message);
    }
  } catch (e) {
    print(e);
  }
}
