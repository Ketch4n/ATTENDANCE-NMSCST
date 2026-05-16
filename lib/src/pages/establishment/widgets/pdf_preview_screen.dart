import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String title;
  final Future<List<int>> Function() buildPdf;

  const PdfPreviewScreen({
    super.key,
    required this.title,
    required this.buildPdf,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // Download button — always visible
          IconButton(
            tooltip: 'Download PDF',
            icon: const Icon(Icons.download),
            onPressed: () async {
              try {
                final bytes = await buildPdf();
                await Printing.sharePdf(
                  bytes: Uint8List.fromList(bytes),
                  filename: '${title.toLowerCase().replaceAll(' ', '_')}.pdf',
                );
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Download failed: $e')),
                  );
                }
              }
            },
          ),
          // Print button — hidden on web (handled by PdfPreview toolbar)
          if (!kIsWeb)
            IconButton(
              tooltip: 'Print',
              icon: const Icon(Icons.print),
              onPressed: () async {
                try {
                  final bytes = await buildPdf();
                  await Printing.layoutPdf(
                    onLayout: (_) async => Uint8List.fromList(bytes),
                  );
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Print failed: $e')),
                    );
                  }
                }
              },
            ),
        ],
      ),
      body: PdfPreview(
        // PdfPreview renders the document and provides its own
        // print / share toolbar at the bottom on all platforms.
        build: (format) async {
          final bytes = await buildPdf();
          return Uint8List.fromList(bytes);
        },
        pageFormats: {
          'A4 Landscape': PdfPageFormat.a4.landscape,
          'A4 Portrait': PdfPageFormat.a4,
        },
        initialPageFormat: PdfPageFormat.a4.landscape,
        allowPrinting: true,
        allowSharing: true,
        canChangePageFormat: true,
        canChangeOrientation: false,
        canDebug: false,
        pdfPreviewPageDecoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        loadingWidget: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 12),
              Text('Generating PDF…'),
            ],
          ),
        ),
        onError: (context, error) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 12),
                Text(
                  'Failed to generate PDF',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
