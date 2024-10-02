import 'package:attendance_nmscst/src/utils/styles/text_style.dart';
import 'package:flutter/material.dart';

Widget loginHeader() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 30),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                'assets/img/nmsct_logo.jpg',
                height: 80,
                width: 80,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text("OJT Attendance\nMonitoring", style: UtilsTextStyle.h1),
      ],
    ),
  );
}
