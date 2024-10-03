// ignore_for_file: use_build_context_synchronously

import 'package:attendance_nmscst/src/data/provider/indexed_stack_pages.dart';
import 'package:attendance_nmscst/src/pages/announcement/announcement_page.dart';
import 'package:attendance_nmscst/src/pages/dashboard/dashboard_page.dart';
import 'package:attendance_nmscst/src/pages/index/components/index_pages_header.dart';
import 'package:attendance_nmscst/src/pages/index/components/sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<IndexedStackPagesEvent>(builder: (context, value, child) {
      return Scaffold(
        body: Row(
          children: [
            const IndexSideBar(),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  indexPagesHeader("Announcement"),
                  Expanded(
                    child: IndexedStack(
                      index: value.quackNew,
                      children: const [
                        AnnouncementPage(),
                        DashboardPage(),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      );
    });
  }
}
