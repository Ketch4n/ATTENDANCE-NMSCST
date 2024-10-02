import 'package:attendance_nmscst/src/utils/styles/color_pallete.dart';
import 'package:attendance_nmscst/src/utils/styles/text_style.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  const CustomTextButton({
    super.key,
    required this.function,
    required this.child,
  });
  final Function function;
  final String child;

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        widget.function();
      },
      autofocus: true,
      style: TextButton.styleFrom(
        fixedSize: const Size.fromHeight(50),
        backgroundColor: UtilsColorPallete.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Center(
        child: Text(
          widget.child,
          style: UtilsTextStyle.h1,
        ),
      ),
    );
  }
}
