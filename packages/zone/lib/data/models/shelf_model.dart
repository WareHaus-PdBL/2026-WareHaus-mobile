import 'package:zone/domain/entities/shelves.dart';

class ShelfModel extends Shelf {
  ShelfModel({
    required String id,
    required String shelfCode,
    required int aisle,
    required int capacity,
    required int currentVolume,
    required String qrCodePath,
  }) : super(
         id: id,
         shelfCode: shelfCode,
         aisle: aisle,
         capacity: capacity,
         currentVolume: currentVolume,
         qrCodePath: qrCodePath,
       );

  factory ShelfModel.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      return int.tryParse(v.toString()) ?? 0;
    }

    return ShelfModel(
      id: json['id']?.toString() ?? '',
      shelfCode: (json['shelfCode'] ?? json['binCode']) as String? ?? '',
      aisle: parseInt(json['aisle']),
      capacity: parseInt(json['capacity']),
      currentVolume: parseInt(json['currentVolume']),
      qrCodePath: json['qrCodePath'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shelfCode': shelfCode,
      'aisle': aisle,
      'capacity': capacity,
      'currentVolume': currentVolume,
      'qrCodePath': qrCodePath,
    };
  }
}
