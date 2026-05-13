import 'package:zone/domain/entities/aisle.dart';

class AisleModel extends Aisle {
  AisleModel({
    required int aisleNumber,
    required bool isEmpty,
    required int totalShelves,
    required int capacity,
    required int occupiedCapacity,
  }) : super(
         aisleNumber: aisleNumber,
         isEmpty: isEmpty,
         totalShelves: totalShelves,
         capacity: capacity,
         occupiedCapacity: occupiedCapacity,
       );

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
