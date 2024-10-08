import 'package:attendance_nmscst/src/utils/styles/color_pallete.dart';
import 'package:attendance_nmscst/src/utils/styles/text_style.dart';
import 'package:flutter/material.dart';

Widget establishmentTitleHeader() {
  return Container(
    height: 50,
    width: double.maxFinite,
    decoration: BoxDecoration(
        color: UtilsColorPallete.blue,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
    child: Center(
        child: Text(
      "Add New Establishment",
      style: UtilsTextStyle.h1,
    )),
  );
}
