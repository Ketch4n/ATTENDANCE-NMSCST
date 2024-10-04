// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:attendance_nmscst/src/components/circular_loading.dart';
import 'package:attendance_nmscst/src/components/snackbar.dart';
import 'package:attendance_nmscst/src/data/instance/instance_text_controller.dart';
import 'package:http/http.dart' as http;
import 'package:attendance_nmscst/src/data/server/url.dart';
import 'package:flutter/material.dart';

Future<void> postAnnouncement(
    BuildContext context, String subject, String body, reload) async {
  if (subject.isEmpty || body.isEmpty) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    customSnackBar(context, 1, "Subject and Body cannot be empty !");
  } else {
    circularLoading(context);

    try {
      final response =
          await http.post(Uri.parse("${Servername.host}announcement"), body: {
        'subject': subject,
        'body': body,
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String message = jsonResponse['message'];
        bool quack = jsonResponse['quack'];

        if (quack) {
          customSnackBar(context, 0, message);
        } else {
          customSnackBar(context, 1, message);
        }
      } else {
        print("Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      print("An error occurred while fetching announcement data: $e");
    } finally {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      reload();
      InstanceTextEditing.clear();
    }
  }
}
