import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

class TicketPdfService {
  Future<File> generateTicketPdf({
    required String bookingId,
    required String eventTitle,
    required String userId,
    required List tickets,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Title
              pw.Text(
                'Fusion Festa – Event Ticket',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 12),

              pw.Text('Booking ID: $bookingId'),
              pw.Text('Event: $eventTitle'),
              pw.Text('User ID: $userId'),

              pw.SizedBox(height: 20),

              // 🔹 QR CODE IN PDF
              pw.Center(
                child: pw.BarcodeWidget(
                  barcode: pw.Barcode.qrCode(),
                  data: bookingId, // 👈 what QR contains
                  width: 180,
                  height: 180,
                ),
              ),

              pw.SizedBox(height: 20),

              pw.Text(
                'Tickets',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 8),

              ...tickets.map(
                (t) => pw.Text(
                  '${t['name']} × ${t['quantity']}  (₹${t['price']})',
                ),
              ),

              pw.SizedBox(height: 30),

              pw.Text(
                'Show this ticket at the entry gate.\nQR code will be scanned.',
              ),
            ],
          );
        },
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$bookingId-ticket.pdf');

    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
