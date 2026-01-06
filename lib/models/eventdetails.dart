import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fusion_festa/models/tickettiermodel.dart';

class EventDetailsModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final String organizerId;
  final String organizerName;
  final String venueName;
  final String venueAddress;
  final DateTime startAt;
  final DateTime endAt;
  final List<TicketTierModel> tickets;

  EventDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.organizerId,
    required this.organizerName,
    required this.venueName,
    required this.venueAddress,
    required this.startAt,
    required this.endAt,
    required this.tickets,
  });

  factory EventDetailsModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return EventDetailsModel(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      category: data['category'],
      imageUrl: data['imageUrl'],
      organizerId: data['organizerId'],
      organizerName: data['organizerName'],
      venueName: data['venue']['name'],
      venueAddress: data['venue']['address'],
      startAt: (data['startAt'] as Timestamp).toDate(),
      endAt: (data['endAt'] as Timestamp).toDate(),
      tickets: (data['tickets'] as List)
          .map((e) => TicketTierModel.fromMap(e))
          .toList(),
    );
  }
}
