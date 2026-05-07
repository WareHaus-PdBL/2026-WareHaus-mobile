import 'package:zone/data/models/bin_model.dart'; // Import modelnya, bukan entity
import 'package:zone/domain/entities/bin.dart';
import 'package:zone/domain/entities/zone.dart';

class ZoneModel extends Zone {
  ZoneModel({
    required super.id,
    required super.zoneCode,
    required super.zoneName,
    required super.category,
    required super.totalAisles,
    required super.totalShelves,
    required super.shelvesCapacity,
    List<Bin>? bins,
  }) : super(
         bins: bins ?? [],
       );

  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    return ZoneModel(
      id: json['id']?.toString() ?? '',
      zoneCode: json['zoneCode'] as String? ?? '',
      zoneName: json['zoneName'] as String? ?? '',
      category: json['category'] as String? ?? '',
      totalAisles: json['totalAisles'] as int? ?? 0,
      totalShelves: json['totalShelves'] as int? ?? 0,
      shelvesCapacity: json['shelvesCapacity'] as int? ?? 0,
      bins: json['bins'] != null
          ? (json['bins'] as List)
                .map((bin) => BinModel.fromJson(bin as Map<String, dynamic>))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'zoneCode': zoneCode,
      'zoneName': zoneName,
      'category': category,
      'totalAisles': totalAisles,
      'totalShelves': totalShelves,
      'shelvesCapacity': shelvesCapacity,
      'bins': bins?.map((bin) {
        if (bin is BinModel) return bin.toJson();
        return {'id': bin.id};
      }).toList(),
    };
    if (id.isNotEmpty) {
      map['id'] = id;
    }
    return map;
  }
}
