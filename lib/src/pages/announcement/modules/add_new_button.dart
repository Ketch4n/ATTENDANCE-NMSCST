import 'package:attendance_nmscst/src/components/material_button.dart';
import 'package:flutter/material.dart';

Widget addNewButton() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: CustomMaterialButton(
          child: "Add New",
          icon: Icons.add_box,
          function: () {},
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}
