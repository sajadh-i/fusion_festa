import 'dart:io';

import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:fusion_festa/services/ticket_pdf_service.dart';

class BookingConfirmationViewModel extends BaseViewModel {
  final String bookingId;
  final String eventTitle;
  final String venue;
  final DateTime startAt;
  final DateTime endAt;
  final double totalPaid;
  final String userId;
  final List bookedTickets;

  // final TicketPdfService _pdfService = TicketPdfService();

  BookingConfirmationViewModel({
    required this.bookingId,
    required this.eventTitle,
    required this.venue,
    required this.startAt,
    required this.endAt,
    required this.totalPaid,
    required this.userId,
    required this.bookedTickets,
  });

  Future<void> downloadTicket() async {
    setBusy(true);

    final File pdf = await pdfservice.generateTicketPdf(
      bookingId: bookingId,
      eventTitle: eventTitle,
      userId: userId,
      tickets: bookedTickets,
    );

    setBusy(false);
    await OpenFilex.open(pdf.path);
  }

  /// 🔗 Share Ticket
  Future<void> shareTicket() async {
    final File pdf = await pdfservice.generateTicketPdf(
      bookingId: bookingId,
      eventTitle: eventTitle,
      userId: userId,
      tickets: bookedTickets,
    );

    await Share.shareXFiles([
      XFile(pdf.path),
    ], text: 'My Fusion Festa Event Ticket');
  }

  void onDone() {
    //  navigationService.clearStackAndShow(Routes.homeView);
    navigationService.clearStackAndShow(Routes.navbarView);
  }
}
