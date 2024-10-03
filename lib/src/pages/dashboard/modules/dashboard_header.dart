import 'package:flutter/material.dart';

Widget dashboardHeader() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/img/nmscst_bg.jpg',
        fit: BoxFit.fill,
      ),
    ),
  );
}
