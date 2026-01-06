import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fusion_festa/models/eventdetails.dart';
import 'package:fusion_festa/models/eventlist.dart';

class EventService {
  final _event = FirebaseFirestore.instance.collection('events');

  Future<void> createEvent({
    required String title,
    required String description,
    required String category,
    required String imageUrl,
    required String organizerId,
    required String organizerName,
    required String venueName,
    required String venueAddress,
    required DateTime startAt,
    required DateTime endAt,
    required List<Map<String, dynamic>> tickets,
  }) async {
    await _event.add({
      'title': title,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'organizerId': organizerId,
      'organizerName': organizerName,
      'venue': {'name': venueName, 'address': venueAddress},
      'startAt': Timestamp.fromDate(startAt),
      'endAt': Timestamp.fromDate(endAt),
      'tickets': tickets,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteEventsByUser(String uid) async {
    final snapshot = await _event.where('organizerId', isEqualTo: uid).get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  final _eventsRef = FirebaseFirestore.instance
      .collection('events')
      .orderBy('startAt');

  Stream<List<EventListModel>> streamAllEvents() {
    return _eventsRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => EventListModel.fromDoc(doc)).toList();
    });
  }

  Future<EventDetailsModel> getEventById(String eventId) async {
    final doc = await FirebaseFirestore.instance
        .collection('events')
        .doc(eventId)
        .get();

    return EventDetailsModel.fromDoc(doc);
  }

  Stream<List<EventListModel>> streamMyEvents() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return _event
        .where('organizerId', isEqualTo: uid)
        .orderBy('startAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((e) => EventListModel.fromDoc(e)).toList(),
        );
  }

  /// 🔹 Delete single event
  Future<void> deleteEvent(String eventId) async {
    await _event.doc(eventId).delete();
  }
}
