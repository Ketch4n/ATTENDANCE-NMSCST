import 'package:flutter/material.dart';

class UtilsTextField {
  static InputDecoration design = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.green),
      borderRadius: BorderRadius.circular(12),
    ),
    fillColor: Colors.grey[200],
    filled: true,
  );
}
