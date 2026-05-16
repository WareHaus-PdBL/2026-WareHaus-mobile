import 'package:zone/data/models/aisle_model.dart';
import 'package:zone/data/models/shelf_model.dart';
import 'package:zone/domain/entities/aisle.dart';
import 'package:zone/domain/entities/shelves.dart';
import 'package:zone/domain/entities/zone.dart';

class ZoneModel extends Zone {
  ZoneModel({
    required String id,
    required String zoneCode,
    required String zoneName,
    required String category,
    required String description,
    required int totalAisle,
    required int shelfPerAisle,
    int capacityPerShelf = 0,
    int emptyShelves = 0,
    List<Shelf>? shelves,
    List<Aisle>? aisles,
  }) : super(
         id: id,
         zoneCode: zoneCode,
         zoneName: zoneName,
         category: category,
         description: description,
         totalAisle: totalAisle,
         shelfPerAisle: shelfPerAisle,
         capacityPerShelf: capacityPerShelf,
         emptyShelves: emptyShelves,
         shelves: shelves ?? [],
         aisles: aisles ?? [],
       );

  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    // Debug print
    print('ZoneModel.fromJson: shelves = ${json['shelves']}');

    // Parse shelves with proper null handling
    List<Shelf>? parsedShelves;
    if (json['shelves'] != null && json['shelves'] is List) {
      print(
        'Parsing shelves list with ${(json['shelves'] as List).length} items',
      );
      parsedShelves = (json['shelves'] as List)
          .map((shelf) => ShelfModel.fromJson(shelf as Map<String, dynamic>))
          .toList();
      print('Parsed shelves: ${parsedShelves.length}');
    } else if (json['bins'] != null && json['bins'] is List) {
      print('Parsing bins list with ${(json['bins'] as List).length} items');
      parsedShelves = (json['bins'] as List)
          .map((shelf) => ShelfModel.fromJson(shelf as Map<String, dynamic>))
          .toList();
    } else {
      print('No shelves or bins found in JSON');
    }

    final zone = ZoneModel(
      id: json['id']?.toString() ?? '',
      zoneCode: json['zoneCode'] as String? ?? '',
      zoneName: json['zoneName'] as String? ?? '',
      category: json['category'] as String? ?? '',
      description: json['description'] as String? ?? '',
      totalAisle: (json['totalAisle'] ?? json['totalAisles']) as int? ?? 0,
      shelfPerAisle:
          (json['shelfPerAisle'] ?? json['totalShelves']) as int? ?? 0,
      capacityPerShelf: json['capacityPerShelf'] as int? ?? 0,
      emptyShelves: json['emptyShelves'] as int? ?? 0,
      shelves: parsedShelves ?? [],
      aisles: (json['aisle'] ?? json['aisles']) != null
          ? ((json['aisle'] ?? json['aisles']) as List)
                .map(
                  (aisle) => AisleModel.fromJson(aisle as Map<String, dynamic>),
                )
                .toList()
          : [],
    );

    print(
      'ZoneModel created: id=${zone.id}, totalAisle=${zone.totalAisle}, shelves.length=${zone.shelves?.length ?? 0}',
    );
    return zone;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'zoneCode': zoneCode,
      'zoneName': zoneName,
      'category': category,
      'description': description,
      'totalAisle': totalAisle,
      'shelfPerAisle': shelfPerAisle,
      'capacityPerShelf': capacityPerShelf,
      'emptyShelves': emptyShelves,
    };

    // Only include id if not empty
    if (id.isNotEmpty) {
      map['id'] = id;
    }

    // Only include shelves if not empty
    if (shelves != null && shelves!.isNotEmpty) {
      map['shelves'] = shelves!.map((shelf) {
        if (shelf is ShelfModel) return shelf.toJson();
        return {'id': shelf.id};
      }).toList();
    }

    // Only include aisles if not empty
    if (aisles != null && aisles!.isNotEmpty) {
      map['aisles'] = aisles!.map((aisle) {
        if (aisle is AisleModel) return aisle.toJson();
        return {'aisleNumber': aisle.aisleNumber};
      }).toList();
    }

    return map;
  }
}
