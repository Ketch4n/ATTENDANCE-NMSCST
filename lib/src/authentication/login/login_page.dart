// ignore_for_file: use_build_context_synchronously

import 'package:attendance_nmscst/src/authentication/auth/auth_index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setInt('userID', 1);

            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const AuthIndex()));
          },
          child: const Text("SET SESSION ID"),
        ),
      ),
    );
  }
}
