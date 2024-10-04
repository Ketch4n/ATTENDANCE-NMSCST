import 'package:attendance_nmscst/src/components/material_button.dart';
import 'package:attendance_nmscst/src/data/constant/constant_text_controller.dart';
import 'package:attendance_nmscst/src/pages/announcement/functions/post.dart';
import 'package:flutter/material.dart';

Widget announcementButtonFooter(context, reload) {
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
                  controller.subject.clear();
                  controller.body.clear();
                },
                child: const Text("Cancel"))),
        Flexible(
          flex: 2,
          child: CustomMaterialButton(
              child: "Save and Send",
              icon: Icons.mail,
              function: () {
                postAnnouncement(context, controller.subject.text,
                    controller.body.text, reload);
              }),
        ),
      ],
    ),
  );
}
