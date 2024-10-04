import 'package:attendance_nmscst/src/pages/announcement/modules/button_footer.dart';
import 'package:attendance_nmscst/src/pages/announcement/widget/body_field.dart';
import 'package:attendance_nmscst/src/pages/announcement/modules/subject_field.dart';
import 'package:attendance_nmscst/src/pages/announcement/modules/title_header.dart';
import 'package:flutter/material.dart';

class AnnouncementAdd extends StatefulWidget {
  const AnnouncementAdd({super.key, required this.reload});
  final Function reload;

  @override
  State<AnnouncementAdd> createState() => _AnnouncementAddState();
}

class _AnnouncementAddState extends State<AnnouncementAdd> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600, minWidth: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          announcementTitleHeader(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  subjectField(),
                  const BodyField(),
                ],
              ),
            ),
          ),
          announcementButtonFooter(context, widget.reload),
        ],
      ),
    );
  }
}
