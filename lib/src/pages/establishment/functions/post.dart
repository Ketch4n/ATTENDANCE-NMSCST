// ignore_for_file: use_build_context_synchronously

import 'package:attendance_nmscst/src/components/circular_loading.dart';
import 'package:attendance_nmscst/src/components/snackbar.dart';
import 'package:attendance_nmscst/src/data/instance/instance_text_controller.dart';
import 'package:attendance_nmscst/src/data/provider/demo_mode_provider.dart';
import 'package:attendance_nmscst/src/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> postEstablishment(
    BuildContext context, String subject, String body, reload) async {
  if (subject.isEmpty || body.isEmpty) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    customSnackBar(context, 1, "Subject and Body cannot be empty !");
    Navigator.of(context).pop();
  } else {
    circularLoading(context);

    final isDemoMode =
        Provider.of<DemoModeProvider>(context, listen: false).isDemoMode;

    try {
      final jsonResponse = await ApiService.post(
        'announcement',
        {
          'subject': subject,
          'body': body,
        },
        isDemoMode: isDemoMode,
      );

      String message = jsonResponse['message'];
      bool quack = jsonResponse['quack'];

      if (quack) {
        customSnackBar(context, 0, message);
      } else {
        customSnackBar(context, 1, message);
      }
    } catch (e) {
      customSnackBar(context, 1, "An error occurred: $e");
    } finally {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      reload();
      InstanceTextEditing.clear();
    }
  }
}
