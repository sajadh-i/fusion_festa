class TicketTierModel {
  final String id;
  final String name;
  final num price;
  final int totalSeats;
  final int soldSeats;

  TicketTierModel({
    required this.id,
    required this.name,
    required this.price,
    required this.totalSeats,
    required this.soldSeats,
  });

  factory TicketTierModel.fromMap(Map<String, dynamic> map) {
    return TicketTierModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      totalSeats: map['totalSeats'],
      soldSeats: map['soldSeats'] ?? 0,
    );
  }
}
