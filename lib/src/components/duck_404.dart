import 'package:attendance_nmscst/src/utils/styles/text_style.dart';
import 'package:flutter/material.dart';

class Duck extends StatelessWidget {
  const Duck({super.key, required this.status, required this.content});
  final String status;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 60, bottom: 30),
          child: SizedBox(
            height: 80,
            width: 80,
            child: Image.asset(
              "assets/img/duck.gif",
            ),
          ),
        ),
        Text(
          status,
          style: UtilsTextStyle.h1,
        ),
        Text(content),
      ],
    );
  }
}
