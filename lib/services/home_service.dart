import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final _db = FirebaseFirestore.instance;

  //Real-time approved events
  Stream<QuerySnapshot> approvedEvents() {
    return _db
        .collection('events')
        .where('status', isEqualTo: 'approved')
        .snapshots();
  }

  //Real-time reviews
  Stream<QuerySnapshot> liveReviews() {
    return _db
        .collection('reviews')
        .orderBy('createdAt', descending: true)
        .limit(20)
        .snapshots();
  }

  //adding reviews
  Future<void> addReview(String userName, String message) async {
    await _db.collection('reviews').add({
      'userName': userName,
      'message': message,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
