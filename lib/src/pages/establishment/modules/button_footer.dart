import 'package:attendance_nmscst/src/components/material_button.dart';
import 'package:flutter/material.dart';

Widget establishmentButtonFooter(context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 2,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"))),
        Flexible(
          flex: 2,
          child: CustomMaterialButton(
              child: "Save", icon: Icons.mail, function: () {}),
        ),
      ],
    ),
  );
}
