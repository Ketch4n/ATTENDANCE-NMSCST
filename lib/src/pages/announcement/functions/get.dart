import 'dart:async';
import 'dart:convert';
import 'package:attendance_nmscst/src/data/server/url.dart';
import 'package:attendance_nmscst/src/pages/announcement/model/announcement_model.dart';
import 'package:http/http.dart' as http;

Future<void> getAnnouncement(
    StreamController<List<AnnouncementModel>> stream) async {
  try {
    final response = await http.get(
      Uri.parse('${Servername.host}announcement'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey('data')) {
        List<dynamic> data = jsonResponse['data'];
        List<AnnouncementModel> announcements =
            data.map((json) => AnnouncementModel.fromJson(json)).toList();

        stream.add(announcements);
      } else {
        // print('No data found in response.');
        stream.add([]);
      }
    } else {
      // print('Failed to load data. HTTP status code: ${response.statusCode}');
      stream.add([]);
    }
  } catch (e) {
    // print('Error occurred: $e');
    stream.add([]);
  }
}
