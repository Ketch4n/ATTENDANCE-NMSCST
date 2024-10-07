// ignore_for_file: use_build_context_synchronously

import 'package:attendance_nmscst/src/data/provider/indexed_stack_pages.dart';
import 'package:attendance_nmscst/src/pages/announcement/announcement_page.dart';
import 'package:attendance_nmscst/src/pages/dashboard/dashboard_page.dart';
import 'package:attendance_nmscst/src/pages/establishment/establishment_page.dart';
import 'package:attendance_nmscst/src/pages/index/components/sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  void selectItem(int value) {
    setState(() {
      IndexedStackPagesEvent.quack = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IndexedStackPagesEvent>(builder: (context, value, child) {
      return Scaffold(
        body: Row(
          children: [
            IndexSideBar(function: selectItem),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: IndexedStack(
                index: value.quackNew,
                children: const [
                  DashboardPage(),
                  AnnouncementPage(),
                  EstablishmentPage(),
                ],
              ),
            )),
          ],
        ),
      );
    });
  }
}
