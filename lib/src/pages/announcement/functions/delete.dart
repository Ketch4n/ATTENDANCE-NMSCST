import 'dart:convert';
import 'package:attendance_nmscst/src/components/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:attendance_nmscst/src/data/server/url.dart';

Future deleteAnnouncement(context, id) async {
  try {
    final response = await http.delete(
      Uri.parse("${Servername.host}announcement/$id"),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      final bool quack = jsonResponse['quack'];
      final String message = jsonResponse['message'];

      if (quack) {
        customSnackBar(context, 0, message);
        return quack;
      } else {
        customSnackBar(context, 1, message);
        return false;
      }
    } else {
      print("Error: ${response.statusCode} ${response.reasonPhrase}");
    }
  } catch (e) {
    print('Error deleting announcement: $e');
  }
}
