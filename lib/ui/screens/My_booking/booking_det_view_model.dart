import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class BookingDetViewModel extends BaseViewModel {
  List<Map<String, dynamic>> activeBookings = [];
  List<Map<String, dynamic>> pastBookings = [];

  StreamSubscription? _sub;

  void initialise() {
    updateExpiredBookings();
    listenToBookings();
  }

  void listenToBookings() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    _sub = FirebaseFirestore.instance
        .collection('bookings')
        .where('userId', isEqualTo: uid)
        .snapshots()
        .listen((snapshot) async {
          List<Map<String, dynamic>> temp = [];

          for (var doc in snapshot.docs) {
            final data = doc.data();

            // get event document
            final eventDoc = await FirebaseFirestore.instance
                .collection('events')
                .doc(data['eventId'])
                .get();

            final eventData = eventDoc.data();

            temp.add({
              'title': data['eventTitle'] ?? '',
              'venue': data['organizerName'] ?? '',
              'dateTime': _formatDate(data['createdAt']),
              'status': data['status'],
              'image': eventData?['imageUrl'] ?? '',
            });
          }

          activeBookings = temp
              .where((e) => e['status'] == 'CONFIRMED')
              .toList();

          pastBookings = temp.where((e) => e['status'] == 'COMPLETED').toList();

          notifyListeners();
        });
  }

  Future<void> updateExpiredBookings() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('userId', isEqualTo: uid)
        .where('status', isEqualTo: 'CONFIRMED')
        .get();

    for (final doc in snapshot.docs) {
      final createdAt = doc['createdAt'] as Timestamp;
      final eventDate = createdAt.toDate();

      if (eventDate.isBefore(DateTime.now())) {
        await doc.reference.update({'status': 'COMPLETED'});
      }
    }
  }

  String _formatDate(Timestamp ts) {
    final d = ts.toDate();
    return "${d.day}/${d.month}/${d.year}";
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
