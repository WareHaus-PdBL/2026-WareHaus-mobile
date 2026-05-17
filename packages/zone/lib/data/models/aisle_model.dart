import 'package:zone/domain/entities/aisle.dart';

class AisleModel extends Aisle {
  AisleModel({
    required super.aisleNumber,
    required super.isEmpty,
    required super.totalShelves,
    required super.capacity,
    required super.occupiedCapacity,
  });

  factory AisleModel.fromJson(Map<String, dynamic> json) => AisleModel(
    aisleNumber: json['aisleNumber'] as int,
    isEmpty: json['isEmpty'] as bool,
    totalShelves: json['totalShelves'] as int,
    capacity: json['capacity'] as int,
    occupiedCapacity: json['occupiedCapacity'] as int,
  );

  Map<String, dynamic> toJson() => {
    'aisleNumber': aisleNumber,
    'isEmpty': isEmpty,
    'totalShelves': totalShelves,
    'capacity': capacity,
    'occupiedCapacity': occupiedCapacity,
  };
}
