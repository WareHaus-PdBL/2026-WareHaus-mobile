class Aisle {
  final int aisleNumber;
  final bool isEmpty;
  final int totalShelves;
  final int capacity;
  final int occupiedCapacity;

  Aisle({
    required this.aisleNumber,
    required this.isEmpty,
    required this.totalShelves,
    required this.capacity,
    required this.occupiedCapacity,
  });

  factory Aisle.fromJson(Map<String, dynamic> json) {
    return Aisle(
      aisleNumber: json['aisleNumber'] as int? ?? 0,
      isEmpty: json['isEmpty'] as bool? ?? false,
      totalShelves: json['totalShelves'] as int? ?? 0,
      capacity: json['capacity'] as int? ?? 0,
      occupiedCapacity: json['occupiedCapacity'] as int? ?? 0,
    );
  }
}
