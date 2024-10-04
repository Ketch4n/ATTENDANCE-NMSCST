import 'package:attendance_nmscst/src/data/constant/constant_text_controller.dart';
import 'package:attendance_nmscst/src/data/provider/textfield_body.dart';
import 'package:attendance_nmscst/src/utils/styles/color_pallete.dart';
import 'package:flutter/material.dart';

class BodyField extends StatefulWidget {
  const BodyField({super.key});

  @override
  State<BodyField> createState() => _BodyFieldState();
}

class _BodyFieldState extends State<BodyField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: UtilsColorPallete.grey,
      child: TextFormField(
        controller: controller.body,
        keyboardType: TextInputType.multiline, // Allow multiline input
        maxLines: null,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          border: OutlineInputBorder(),
          labelText: 'Body...',
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
        ),

        onChanged: (text) {
          setState(
            () {
              TextfieldBody.lines = text.split('\n');
              if (TextfieldBody.lines.length > 4) {
                TextfieldBody.lines = TextfieldBody.lines.sublist(0, 4);
                controller.body.text = TextfieldBody.lines.join('\n');
                controller.body.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.body.text.length),
                );
              }
            },
          );
        },
      ),
    );
  }
}
