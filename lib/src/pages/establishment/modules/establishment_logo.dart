import 'package:flutter/material.dart';

Widget estabLogo() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Image.asset(
      "assets/img/estab.png",
      height: 30,
      width: 30,
      fit: BoxFit.cover,
    ),
  );
}
