import 'package:attendance_nmscst/src/pages/index/components/cards.dart';
import 'package:flutter/material.dart';

Widget dashboardBody(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8.0, // spacing between cards
      runSpacing: 8.0, // spacing between rows
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: const IndexCard(
            count: "0",
            icon: Icons.timelapse_sharp,
            child: 'List of Late',
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const IndexCard(
            count: "0",
            icon: Icons.location_off_sharp,
            child: 'Outside Range',
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const IndexCard(
            count: "0",
            icon: Icons.person_off_outlined,
            child: 'Absent',
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const IndexCard(
            count: "0",
            icon: Icons.location_city,
            child: 'All Establishment',
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const IndexCard(
            count: "0",
            icon: Icons.school,
            child: 'All Students',
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const IndexCard(
            count: "0",
            icon: Icons.mail,
            child: 'Announcement',
          ),
        ),
      ],
    ),
  );
}
