// ignore_for_file: use_build_context_synchronously

import 'package:attendance_nmscst/src/authentication/login/modules/login_body.dart';
import 'package:attendance_nmscst/src/authentication/login/modules/login_header.dart';
import 'package:attendance_nmscst/src/authentication/login/modules/login_subheader.dart';
import 'package:attendance_nmscst/src/authentication/login/utils/background_color.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: UtilsLogin.bg,
        child: Column(
          children: [
            loginHeader(),
            loginSubHeader(),
            const LoginBody(),
          ],
        ),
      ),
    );
  }
}
