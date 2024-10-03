// ignore_for_file: use_build_context_synchronously

import 'package:attendance_nmscst/src/pages/index/components/sidebar/sidebar.dart';
import 'package:attendance_nmscst/src/pages/index/modules/index_body.dart';
import 'package:attendance_nmscst/src/pages/index/modules/index_header.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const IndexSideBar(),
          Expanded(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        indexHeader(),
                        indexBody(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
