import 'package:attendance_nmscst/src/utils/styles/color_pallete.dart';
import 'package:flutter/material.dart';

Widget sidebarHeader() {
  return Container(
    color: UtilsColorPallete.blue,
    constraints: const BoxConstraints(maxWidth: 900),
    child: const SizedBox(
      height: 170,
      width: double.maxFinite,
    ),
  );
}
