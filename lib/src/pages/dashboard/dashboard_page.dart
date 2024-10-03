import 'package:attendance_nmscst/src/pages/dashboard/modules/dashboard_body.dart';
import 'package:attendance_nmscst/src/pages/dashboard/modules/dashboard_header.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                dashboardHeader(),
                dashboardBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
