// ignore_for_file: use_build_context_synchronously

import 'package:attendance_nmscst/src/authentication/logout/functions/logout.dart';
import 'package:attendance_nmscst/src/data/index/user_role_value.dart';
import 'package:attendance_nmscst/src/data/provider/user_session.dart';
import 'package:attendance_nmscst/src/pages/index/components/sidebar/modules/sidebar_header.dart';
import 'package:attendance_nmscst/src/pages/index/components/sidebar/modules/sidebar_user_account.dart';
import 'package:attendance_nmscst/src/utils/styles/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexSideBar extends StatefulWidget {
  const IndexSideBar({
    super.key,
    required this.function,
  });
  final Function(int) function;

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
              onTap: () {
                widget.function(0);
              },
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
              onTap: () {
                widget.function(2);
              },
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
              leading: const Icon(Icons.mail),
              title: const Text('Announcement'),
              onTap: () {
                widget.function(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_off_sharp),
              title: const Text('Outside Range'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person_off_outlined),
              title: const Text('Absent'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.timelapse_sharp),
              title: const Text('late'),
              onTap: () {},
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.archive),
              title: const Text('Archived'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Log-out'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () => logout(context),
            ),
          ],
        ),
      );
    });
  }
}
