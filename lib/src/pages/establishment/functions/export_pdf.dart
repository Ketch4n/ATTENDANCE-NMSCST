import 'package:attendance_nmscst/src/pages/establishment/model/establishment_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> exportPDF(List<EstablishmentModel> estab) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Text('Establishment Data',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: [
                'Establishment Name',
                'Location',
                'Hours Required',
              ],
              data: estab.map((estabModel) {
                return [
                  estabModel.establishmentName,
                  estabModel.location,
                  estabModel.hoursRequired,
                ];
              }).toList(),
            ),
          ],
        );
      },
    ),
  );

  try {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  } catch (e) {
    print('Error while generating PDF: $e');
  }
}
