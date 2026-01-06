import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:stacked/stacked.dart';
import 'booking_confirmation_view_model.dart';

class BookingConfirmationView extends StatelessWidget {
  final String bookingId;
  final String eventTitle;
  final String venue;
  final DateTime startAt;
  final DateTime endAt;
  final double totalPaid;
  final String userId;
  final List bookedTickets;

  const BookingConfirmationView({
    super.key,
    required this.bookingId,
    required this.eventTitle,
    required this.venue,
    required this.startAt,
    required this.endAt,
    required this.totalPaid,
    required this.userId,
    required this.bookedTickets,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<BookingConfirmationViewModel>.reactive(
      viewModelBuilder: () => BookingConfirmationViewModel(
        bookingId: bookingId,
        eventTitle: eventTitle,
        venue: venue,
        startAt: startAt,
        endAt: endAt,
        totalPaid: totalPaid,
        userId: userId,
        bookedTickets: bookedTickets,
      ),
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF0D0606),
          appBar: AppBar(
            backgroundColor: const Color(0xFF141010),
            elevation: 0,
            title: const Text(
              'Ticket Confirmed',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: vm.onDone,
                child: const Text(
                  'Done',
                  style: TextStyle(color: Color(0xFFFF8A3D)),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  /// ✅ Success Icon
                  Container(
                    height: 90,
                    width: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1E2A22),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Color(0xFF46C980),
                      size: 48,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Booking Confirmed!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    vm.eventTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFB7A9A6),
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// 🎫 QR + Booking ID
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: _cardDecoration(),
                    child: Column(
                      children: [
                        QrImageView(
                          data: vm.bookingId,
                          size: size.width * 0.45,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'BOOKING ID',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFFB7A9A6),
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          vm.bookingId,
                          style: const TextStyle(
                            fontSize: 18,
                            letterSpacing: 1.6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 📍 Event Info
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: _cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoRow(Icons.calendar_today, '${vm.startAt}'),
                        const SizedBox(height: 8),
                        _infoRow(Icons.location_on_outlined, vm.venue),
                        const Divider(height: 24),
                        _infoRow(
                          Icons.currency_rupee,
                          'Paid: ₹${vm.totalPaid.toStringAsFixed(2)}',
                          highlight: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// 📥 Actions
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: vm.isBusy ? null : vm.downloadTicket,
                          icon: const Icon(Icons.download_rounded),
                          label: const Text('Download'),
                          style: _primaryButton(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 54,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: vm.shareTicket,
                          style: _secondaryButton(),
                          child: const Icon(Icons.share_rounded),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ---------- UI helpers ----------

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: const Color(0xFF181012),
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.6),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String text, {bool highlight = false}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFFB7A9A6)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: highlight ? const Color(0xFF46C980) : Colors.white,
              fontWeight: highlight ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  ButtonStyle _primaryButton() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF8A3D),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      elevation: 10,
    );
  }

  ButtonStyle _secondaryButton() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF262031),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
    );
  }
}
