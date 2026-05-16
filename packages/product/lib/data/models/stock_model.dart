import 'package:product/domain/entities/stock.dart';

class StockModel extends Stock {
  StockModel({
    required String id,
    required int shelfId,
    required String productId,
    required int quantity,
    String shelfCode = '',
    int zoneId = 0,
    String zoneCode = '',
    String zoneName = '',
    int aisle = 0,
    String locationName = '',
    int shelfCapacity = 0,
    int shelfCurrentVolume = 0,
    int shelfAvailableCapacity = 0,
    String qrCodePath = '',
  }) : super(
         id: id,
         shelfId: shelfId,
         productId: productId,
         quantity: quantity,
         shelfCode: shelfCode,
         zoneId: zoneId,
         zoneCode: zoneCode,
         zoneName: zoneName,
         aisle: aisle,
         locationName: locationName,
         shelfCapacity: shelfCapacity,
         shelfCurrentVolume: shelfCurrentVolume,
         shelfAvailableCapacity: shelfAvailableCapacity,
         qrCodePath: qrCodePath,
       );

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      id: json['id']?.toString() ?? '',
      shelfId: json['shelfId'] as int? ?? 0,
      productId: json['productId'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
      shelfCode: (json['shelfCode'] ?? json['binCode']) as String? ?? '',
      zoneId: json['zoneId'] as int? ?? 0,
      zoneCode: json['zoneCode'] as String? ?? '',
      zoneName: json['zoneName'] as String? ?? '',
      aisle: json['aisle'] as int? ?? 0,
      locationName: json['locationName'] as String? ?? '',
      shelfCapacity: json['shelfCapacity'] as int? ?? 0,
      shelfCurrentVolume: json['shelfCurrentVolume'] as int? ?? 0,
      shelfAvailableCapacity: json['shelfAvailableCapacity'] as int? ?? 0,
      qrCodePath: json['qrCodePath'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'shelfId': shelfId,
    'productId': productId,
    'quantity': quantity,
    'shelfCode': shelfCode,
    'zoneId': zoneId,
    'zoneCode': zoneCode,
    'zoneName': zoneName,
    'aisle': aisle,
    'locationName': locationName,
    'shelfCapacity': shelfCapacity,
    'shelfCurrentVolume': shelfCurrentVolume,
    'shelfAvailableCapacity': shelfAvailableCapacity,
    'qrCodePath': qrCodePath,
  };
}
