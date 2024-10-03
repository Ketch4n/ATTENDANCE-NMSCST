import 'package:attendance_nmscst/src/pages/index/components/cards.dart';
import 'package:flutter/material.dart';

Widget indexBody(context) {
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
            child: 'List of Late',
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const IndexCard(
            count: "0",
            child: 'Outside Range',
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const IndexCard(
            count: "0",
            child: 'Absent',
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const IndexCard(
            count: "0",
            child: 'All Establishment',
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const IndexCard(
            count: "0",
            child: 'All Students',
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const IndexCard(
            count: "0",
            child: 'Announcement',
          ),
        ),
      ],
    ),
  );
}
