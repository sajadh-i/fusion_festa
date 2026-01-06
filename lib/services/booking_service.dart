import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fusion_festa/models/eventdetails.dart';

class BookingService {
  final _db = FirebaseFirestore.instance;

  //Create booking + update sold seats (transaction safe)
  Future<String> createBooking({
    required EventDetailsModel event,
    required Map<String, int> selectedQty,
    required double displayAmount,
    required String paymentId,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final bookingRef = _db.collection('bookings').doc();
    final eventRef = _db.collection('events').doc(event.id);

    //Human-readable booking id
    final bookingId =
        'FF-${DateTime.now().year}-${bookingRef.id.substring(0, 6).toUpperCase()}';

    await _db.runTransaction((transaction) async {
      final eventSnap = await transaction.get(eventRef);
      if (!eventSnap.exists) throw Exception('Event not found');

      final data = eventSnap.data()!;
      final List tickets = List.from(data['tickets']);

      // ✅ Update sold seats safely
      for (int i = 0; i < tickets.length; i++) {
        final tierId = tickets[i]['id'];
        final qty = selectedQty[tierId] ?? 0;

        if (qty > 0) {
          final int sold = tickets[i]['soldSeats'] ?? 0;
          final int total = tickets[i]['totalSeats'];

          if (sold + qty > total) {
            throw Exception('Not enough seats available');
          }

          tickets[i]['soldSeats'] = sold + qty;
        }
      }

      transaction.update(eventRef, {'tickets': tickets});

      final bookedTickets = tickets
          .where((t) => (selectedQty[t['id']] ?? 0) > 0)
          .map(
            (t) => {
              'tierId': t['id'],
              'name': t['name'],
              'price': t['price'],
              'quantity': selectedQty[t['id']],
            },
          )
          .toList();

      transaction.set(bookingRef, {
        'bookingId': bookingId,
        'eventId': event.id,
        'eventTitle': event.title,
        'organizerId': event.organizerId,
        'organizerName': event.organizerName,
        'userId': uid,
        'tickets': bookedTickets,
        'displayAmount': displayAmount,
        'paidAmount': 1, // dummy
        'paymentId': paymentId,
        'status': 'CONFIRMED',
        'createdAt': FieldValue.serverTimestamp(),
      });
    });

    return bookingId;
  }
}
