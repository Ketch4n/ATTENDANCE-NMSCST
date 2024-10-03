import 'package:attendance_nmscst/src/data/provider/user_session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget userAccount() {
  return Consumer<UserSessionEvent>(builder: (context, value, child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              onTap: () {},
              child: Image.asset(
                'assets/img/nmsct_logo.jpg',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value.nameValue!,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
              Text(
                value.emailValue!,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  });
}
