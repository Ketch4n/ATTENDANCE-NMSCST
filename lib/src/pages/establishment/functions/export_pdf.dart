import 'package:attendance_nmscst/src/pages/establishment/model/establishment_model.dart';
import 'package:attendance_nmscst/src/pages/establishment/widgets/pdf_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// Builds the PDF bytes — shared between preview and direct print.
Future<List<int>> buildEstablishmentPdf(List<EstablishmentModel> estab) async {
  final fontData = await PdfGoogleFonts.nunitoRegular();
  final fontBold = await PdfGoogleFonts.nunitoBold();

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Establishment Report',
              style: pw.TextStyle(font: fontBold, fontSize: 22),
            ),
            pw.SizedBox(height: 16),
            pw.TableHelper.fromTextArray(
              headerStyle: pw.TextStyle(
                font: fontBold,
                fontSize: 11,
                color: PdfColors.white,
              ),
              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.blue700,
              ),
              cellStyle: pw.TextStyle(font: fontData, fontSize: 10),
              rowDecoration: const pw.BoxDecoration(color: PdfColors.white),
              oddRowDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey100),
              headers: [
                'Establishment Name',
                'Location',
                'Hours Required',
                'Radius',
              ],
              data: estab.map((e) {
                return [
                  e.establishmentName,
                  e.location,
                  e.hoursRequired,
                  '${e.radius} meter/s',
                ];
              }).toList(),
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}

/// Opens the print preview screen.
Future<void> exportPDF(
    BuildContext context, List<EstablishmentModel> estab) async {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => PdfPreviewScreen(
        title: 'Establishment Report',
        buildPdf: () => buildEstablishmentPdf(estab),
      ),
    ),
  );
}
