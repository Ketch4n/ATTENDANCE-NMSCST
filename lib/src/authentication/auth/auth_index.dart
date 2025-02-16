import 'package:attendance_nmscst/src/authentication/login/login_page.dart';
import 'package:attendance_nmscst/src/data/provider/user_session.dart';
import 'package:attendance_nmscst/src/pages/index/index_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthIndex extends StatefulWidget {
  const AuthIndex({super.key});

  @override
  State<AuthIndex> createState() => _AuthIndexState();
}

class _AuthIndexState extends State<AuthIndex> {
  bool showLogin = true;
  @override
  void initState() {
    super.initState();
    checkUserSession();
  }

  Future<void> checkUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userID');
    final uname = prefs.getString('userNAME');
    final uemail = prefs.getString('userEMAIL');
    final urole = prefs.getInt('userROLE');
    if (userId != null) {
      setState(() {
        showLogin = false;
        UserSessionEvent.id = userId;
        UserSessionEvent.email = uemail;
        UserSessionEvent.name = uname;
        UserSessionEvent.role = urole;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showLogin ? const LoginPage() : const IndexPage(),
    );
  }
}
