import 'package:cloud_firestore/cloud_firestore.dart';

class EventListModel {
  final String id;
  final String title;
  final String category;
  final String imageUrl;
  final String venue;
  final DateTime startAt;

  EventListModel({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.venue,
    required this.startAt,
  });

  factory EventListModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return EventListModel(
      id: doc.id,
      title: data['title'] ?? '',
      category: data['category'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      venue: data['venue'] != null ? data['venue']['name'] ?? '' : '',
      startAt: (data['startAt'] as Timestamp).toDate(),
    );
  }
}
