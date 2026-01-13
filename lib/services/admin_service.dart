import 'package:cloud_firestore/cloud_firestore.dart';

class AdminService {
  final _events = FirebaseFirestore.instance.collection('events');

  Stream<QuerySnapshot> allEventsStream() {
    return _events.orderBy('createdAt', descending: true).snapshots();
  }

  //Approve event
  Future<void> approveEvent(String eventId) async {
    await _events.doc(eventId).update({
      'status': 'approved',
      'approvedAt': FieldValue.serverTimestamp(),
    });
  }

  //Reject event
  Future<void> rejectEvent(String eventId) async {
    await _events.doc(eventId).update({
      'status': 'rejected',
      'rejectedAt': FieldValue.serverTimestamp(),
    });
  }
}
