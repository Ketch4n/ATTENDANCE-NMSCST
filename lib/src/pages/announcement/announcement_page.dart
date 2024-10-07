import 'dart:async';
import 'package:attendance_nmscst/src/pages/announcement/functions/delete.dart';
import 'package:attendance_nmscst/src/pages/announcement/functions/get.dart';
import 'package:attendance_nmscst/src/pages/announcement/model/announcement_model.dart';
import 'package:attendance_nmscst/src/pages/announcement/modules/add_new_button.dart';
import 'package:attendance_nmscst/src/pages/index/components/index_pages_header.dart';
import 'package:flutter/material.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({super.key});

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  final StreamController<List<AnnouncementModel>> _announcementStream =
      StreamController<List<AnnouncementModel>>();

  void _fetchAnnouncements() async {
    await getAnnouncement(_announcementStream);
  }

  @override
  void initState() {
    super.initState();
    _fetchAnnouncements();
  }

  @override
  void dispose() {
    _announcementStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        indexPagesHeader("Announcement"),
        Expanded(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  addNewButton(context, _fetchAnnouncements),
                  Expanded(
                    child: StreamBuilder<List<AnnouncementModel>>(
                      stream: _announcementStream.stream,
                      builder: (context, snapshot) {
                        List<AnnouncementModel> announcements =
                            snapshot.data ?? [];
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No announcements available.'));
                        } else {
                          return ListView.builder(
                            itemCount: announcements.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue),
                                    child: const Icon(
                                      Icons.mail,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(announcements[index].subject),
                                  subtitle: Text(
                                    announcements[index]
                                        .body
                                        .replaceAll('<br>', '\n'),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => removeAnnouncement(
                                      context,
                                      announcements[index].id,
                                      _fetchAnnouncements,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
