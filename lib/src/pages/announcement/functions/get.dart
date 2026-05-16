import 'dart:async';
import 'package:attendance_nmscst/src/data/services/api_service.dart';
import 'package:attendance_nmscst/src/pages/announcement/model/announcement_model.dart';

Future<void> getAnnouncement(StreamController<List<AnnouncementModel>> stream,
    {bool isDemoMode = false}) async {
  try {
    final jsonResponse = await ApiService.get(
      'announcement',
      isDemoMode: isDemoMode,
    );

    if (jsonResponse.containsKey('data')) {
      List<dynamic> data = jsonResponse['data'];
      List<AnnouncementModel> announcements =
          data.map((json) => AnnouncementModel.fromJson(json)).toList();

      stream.add(announcements);
    } else {
      stream.add([]);
    }
  } catch (e) {
    stream.add([]);
  }
}
