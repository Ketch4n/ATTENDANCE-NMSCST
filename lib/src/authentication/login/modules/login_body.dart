import 'package:attendance_nmscst/src/authentication/login/components/text_button.dart';
import 'package:attendance_nmscst/src/authentication/login/functions/login.dart';
import 'package:attendance_nmscst/src/data/constant/constant_text_controller.dart';
import 'package:attendance_nmscst/src/utils/styles/text_field.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool _isObscure = true;

  @override
  void dispose() {
    controller.email.clear();
    controller.pass.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            TextField(
              controller: controller.email,
              enableSuggestions: false,
              autocorrect: false,
              decoration: UtilsTextField.design.copyWith(hintText: "Username"),
            ),
            const SizedBox(height: 10),
            TextField(
              obscureText: _isObscure,
              enableSuggestions: false,
              controller: controller.pass,
              decoration: UtilsTextField.design.copyWith(
                hintText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomTextButton(function: () => login(context), child: "LOGIN")
          ],
        ),
      ),
    );
  }
}
