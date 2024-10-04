import 'package:attendance_nmscst/src/components/material_button.dart';
import 'package:attendance_nmscst/src/components/show_dialog.dart';
import 'package:attendance_nmscst/src/pages/announcement/announcement_add.dart';
import 'package:flutter/material.dart';

Widget addNewButton(context, reload) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: CustomMaterialButton(
          child: "Add New",
          icon: Icons.add_box,
          function: () {
            showCustomDialog(
              context,
              AnnouncementAdd(
                reload: reload,
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}
