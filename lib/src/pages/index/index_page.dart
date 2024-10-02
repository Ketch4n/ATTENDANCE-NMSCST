// ignore_for_file: use_build_context_synchronously

import 'package:attendance_nmscst/src/authentication/auth/auth_index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.remove('userID');

            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AuthIndex()),
            );
          },
          child: const Text("REMOVE SESSION ID"),
        ),
      ),
    );
  }
}
