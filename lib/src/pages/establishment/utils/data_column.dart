import 'package:flutter/material.dart';

DataColumn dataColumn(header) {
  return DataColumn(
    label: Text(
      header,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}
