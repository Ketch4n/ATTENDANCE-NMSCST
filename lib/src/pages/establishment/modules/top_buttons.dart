// import 'package:attendance_nmscst/src/components/material_button.dart';
import 'package:attendance_nmscst/src/components/material_button.dart';
import 'package:attendance_nmscst/src/pages/establishment/functions/export_pdf.dart';
import 'package:flutter/material.dart';

Widget establishmentHeader(estab) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomMaterialButton(
        child: "Add New",
        icon: Icons.add,
        function: () {
          // Implement your add new logic here
        },
      ),
      CustomMaterialButton(
        child: "Report",
        icon: Icons.picture_as_pdf,
        function: () => exportPDF(estab),
      ),
    ],
  );
}
