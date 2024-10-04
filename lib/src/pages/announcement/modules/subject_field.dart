import 'package:attendance_nmscst/src/components/textfield.dart';
import 'package:attendance_nmscst/src/data/constant/constant_text_controller.dart';
import 'package:attendance_nmscst/src/utils/styles/color_pallete.dart';
import 'package:flutter/material.dart';

Widget subjectField() {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: CustomTextField(
          controller: controller.subject,
          label: "Subject",
          fillcolor: UtilsColorPallete.grey,
          readOnly: false),
    ),
  );
}
