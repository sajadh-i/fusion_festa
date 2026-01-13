class EventRequest {
  final String id;
  final String imageUrl;
  final String tag;
  final String status;
  final String title;
  final String organizer;
  final String dateText;

  EventRequest({
    required this.id,
    required this.imageUrl,
    required this.tag,
    required this.status,
    required this.title,
    required this.organizer,
    required this.dateText,
  });

  EventRequest copyWith({String? status}) => EventRequest(
    id: id,
    imageUrl: imageUrl,
    tag: tag,
    status: status ?? this.status,
    title: title,
    organizer: organizer,
    dateText: dateText,
  );
}
