import 'package:zone/domain/entities/bin.dart';

class Zone {
  final String id;
  final String zoneCode;
  final String zoneName;
  final String category;
  final int totalAisles;
  final int totalShelves;
  final int shelvesCapacity;
  final List<Bin>? bins;

  Zone({
    required this.id,
    required this.zoneCode,
    required this.zoneName,
    required this.category,
    required this.totalAisles,
    required this.totalShelves,
    required this.shelvesCapacity,
    this.bins,
  });

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id']?.toString() ?? '',
      zoneCode: json['zoneCode'] as String? ?? '',
      zoneName: json['zoneName'] as String? ?? '',
      category: json['category'] as String? ?? '',
      totalAisles: json['totalAisles'] as int? ?? 0,
      totalShelves: json['totalShelves'] as int? ?? 0,
      shelvesCapacity: json['shelvesCapacity'] as int? ?? 0,
      bins: json['bins'] != null
          ? (json['bins'] as List).map((bin) => Bin.fromJson(bin)).toList()
          : null,
    );
  }
}
