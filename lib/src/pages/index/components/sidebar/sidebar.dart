// ignore_for_file: use_build_context_synchronously

import 'package:attendance_nmscst/src/authentication/auth/auth_index.dart';
import 'package:attendance_nmscst/src/components/confirmation_dialog.dart';
import 'package:attendance_nmscst/src/data/index/user_role_value.dart';
import 'package:attendance_nmscst/src/data/provider/user_session.dart';
import 'package:attendance_nmscst/src/pages/index/components/sidebar/modules/sidebar_header.dart';
import 'package:attendance_nmscst/src/pages/index/components/sidebar/modules/sidebar_user_account.dart';
import 'package:attendance_nmscst/src/utils/styles/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexSideBar extends StatefulWidget {
  const IndexSideBar({super.key});

  @override
  State<IndexSideBar> createState() => _IndexSideBarState();
}

class _IndexSideBarState extends State<IndexSideBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserSessionEvent>(builder: (context, value, child) {
      return Drawer(
        backgroundColor: UtilsColorPallete.grey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 170,
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      sidebarHeader(),
                      userAccount(),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Text(
                userRoleValue(value.roleValue!),
                style: const TextStyle(fontSize: 20),
              ),
              trailing: const Icon(
                Icons.circle,
                color: Colors.green,
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.home_sharp),
              title: const Text('Dashboard'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {},
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Admin Accounts'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text('Establishment'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Students'),
              onTap: () {},
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Announcement'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Outside Range'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Absent'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('late'),
              onTap: () {},
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Archived'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Log-out'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () async {
                confirmationDialog(context, "Confirm Logout ?", "", () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove('userID');
                  prefs.remove('userNAME');
                  prefs.remove('userEMAIL');
                  prefs.remove('userROLE');

                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const AuthIndex(),
                    ),
                  );
                });
              },
            ),
          ],
        ),
      );
    });
  }
}
