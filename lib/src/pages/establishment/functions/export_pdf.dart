import 'package:attendance_nmscst/src/data/provider/establishment_list.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

Future<void> exportPDF(BuildContext context) async {
  final establishmentList =
      Provider.of<EstablishmentList>(context, listen: false);
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Establishment Data',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                // Headers
                pw.TableRow(
                  children: [
                    pw.Text('Establishment Name',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Location',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Hours Required',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Radius',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                // Data Rows
                ...establishmentList.establishments.map((estabModel) {
                  return pw.TableRow(
                    children: [
                      pw.Text(estabModel.establishmentName),
                      pw.Text(estabModel.location),
                      pw.Text(estabModel.hoursRequired.toString()),
                      pw.Text(estabModel.radius.toString()),
                    ],
                  );
                }),
              ],
            ),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
