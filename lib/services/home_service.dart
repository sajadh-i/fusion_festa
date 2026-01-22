import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final _db = FirebaseFirestore.instance;

  //Real time approved events
  Stream<QuerySnapshot> approvedEvents() {
    return _db
        .collection('events')
        .where('status', isEqualTo: 'approved')
        .snapshots();
  }

  //adding reviews

  Stream<QuerySnapshot> liveReviews() {
    return _db
        .collection('reviews')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> addReview({
    required String userId,
    required String userName,
    required String text,
    String? imageUrl,
  }) async {
    await _db.collection('reviews').add({
      'userId': userId,
      'userName': userName,
      'text': text,
      'imageUrl': imageUrl,
      'likeCount': 0,
      'likedBy': [],
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  //delete reviews
  Future<void> deleteReview(String reviewId) async {
    await _db.collection('reviews').doc(reviewId).delete();
  }

  //review like
  Future<void> toggleLike(String reviewId, String uid, bool isLiked) async {
    final ref = _db.collection('reviews').doc(reviewId);

    if (isLiked) {
      await ref.update({
        'likedBy': FieldValue.arrayRemove([uid]),
        'likeCount': FieldValue.increment(-1),
      });
    } else {
      await ref.update({
        'likedBy': FieldValue.arrayUnion([uid]),
        'likeCount': FieldValue.increment(1),
      });
    }
  }
}
