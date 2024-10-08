import 'dart:async';
import 'package:attendance_nmscst/src/components/material_button.dart';
import 'package:attendance_nmscst/src/components/show_dialog.dart';
import 'package:attendance_nmscst/src/pages/establishment/establishment_add.dart';
import 'package:attendance_nmscst/src/pages/establishment/functions/export_pdf.dart';
import 'package:attendance_nmscst/src/pages/establishment/functions/get.dart';
import 'package:attendance_nmscst/src/pages/establishment/model/establishment_model.dart';
import 'package:attendance_nmscst/src/pages/establishment/utils/data_column.dart';
import 'package:attendance_nmscst/src/pages/establishment/utils/data_row_cell.dart';
import 'package:attendance_nmscst/src/pages/index/components/index_pages_header.dart';
import 'package:flutter/material.dart';

class EstablishmentPage extends StatefulWidget {
  const EstablishmentPage({super.key});

  @override
  State<EstablishmentPage> createState() => _EstablishmentPageState();
}

class _EstablishmentPageState extends State<EstablishmentPage> {
  final StreamController<List<EstablishmentModel>> _establishmentStream =
      StreamController<List<EstablishmentModel>>();

  void _fetchEstablishment() async {
    await getEstablishment(_establishmentStream);
  }

  @override
  void initState() {
    super.initState();
    _fetchEstablishment();
  }

  @override
  void dispose() {
    _establishmentStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        indexPagesHeader("Establishment"),
        Expanded(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: StreamBuilder<List<EstablishmentModel>>(
                      stream: _establishmentStream.stream,
                      builder: (context, snapshot) {
                        List<EstablishmentModel> establishment =
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
                              child: Text('No establishment available.'));
                        } else {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomMaterialButton(
                                    child: "Add New",
                                    icon: Icons.add,
                                    function: () {
                                      showCustomDialog(
                                        context,
                                        const EstablishmentAdd(),
                                      );
                                    },
                                  ),
                                  CustomMaterialButton(
                                    child: "Report",
                                    icon: Icons.picture_as_pdf,
                                    function: () => exportPDF(establishment),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columns: [
                                    dataColumn("Establishment Name"),
                                    dataColumn("Location"),
                                    dataColumn("Arrival AM"),
                                    dataColumn("Departure AM"),
                                    dataColumn("Arrival PM"),
                                    dataColumn("Departure PM"),
                                    dataColumn("Hours Required"),
                                    dataColumn("Radius"),
                                    dataColumn("Options"),
                                  ],
                                  rows: establishment
                                      .map(
                                        (estab) => DataRow(
                                          cells: [
                                            dataRowCell(estab.establishmentName,
                                                logo: true),
                                            dataRowCell(estab.location),
                                            dataRowCell("IN AM"),
                                            dataRowCell("OUT AM"),
                                            dataRowCell("IN PM"),
                                            dataRowCell("OUT PM"),
                                            dataRowCell(estab.hoursRequired),
                                            dataRowCell(
                                                "${estab.radius} meter/s"),
                                            dataRowCellWidget(context, estab.id,
                                                _fetchEstablishment),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
