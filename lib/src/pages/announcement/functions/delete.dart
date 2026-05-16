// ignore_for_file: use_build_context_synchronously

import 'package:attendance_nmscst/src/components/circular_loading.dart';
import 'package:attendance_nmscst/src/components/confirmation_dialog.dart';
import 'package:attendance_nmscst/src/components/snackbar.dart';
import 'package:attendance_nmscst/src/data/provider/demo_mode_provider.dart';
import 'package:attendance_nmscst/src/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void removeAnnouncement(context, id, reload) async {
  await confirmationDialog(
    context,
    "Confirm Delete ?",
    "Announcement Record",
    () async {
      await deleteAnnouncement(context, id, reload);
    },
  );
}

Future<void> deleteAnnouncement(context, id, reload) async {
  circularLoading(context);

  final isDemoMode =
      Provider.of<DemoModeProvider>(context, listen: false).isDemoMode;

  try {
    final jsonResponse = await ApiService.delete(
      'announcement/$id',
      isDemoMode: isDemoMode,
    );

    final bool quack = jsonResponse['quack'];
    final String message = jsonResponse['message'];

    if (quack) {
      customSnackBar(context, 0, message);
    } else {
      customSnackBar(context, 1, message);
    }
  } catch (e) {
    customSnackBar(context, 1, "An error occurred: $e");
  } finally {
    Navigator.of(context).pop();
    reload();
  }
}
