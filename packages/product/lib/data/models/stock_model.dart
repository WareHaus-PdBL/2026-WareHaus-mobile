import 'package:product/domain/entities/stock.dart';

class StockModel extends Stock {
  StockModel({
    required super.id,
    required super.shelfId,
    required super.productId,
    required super.quantity,
    super.shelfCode,
    super.zoneId,
    super.zoneCode,
    super.zoneName,
    super.aisle,
    super.locationName,
    super.shelfCapacity,
    super.shelfCurrentVolume,
    super.shelfAvailableCapacity,
    super.qrCodePath,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      id: json['id']?.toString() ?? '',
      shelfId: json['shelfId'] as int? ?? 0,
      productId: json['productId'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
      shelfCode: json['shelfCode'] as String?,
      zoneId: json['zoneId'] as int?,
      zoneCode: json['zoneCode'] as String?,
      zoneName: json['zoneName'] as String?,
      aisle: json['aisle'] as int?,
      locationName: json['locationName'] as String?,
      shelfCapacity: json['shelfCapacity'] as int?,
      shelfCurrentVolume: json['shelfCurrentVolume'] as int?,
      shelfAvailableCapacity: json['shelfAvailableCapacity'] as int?,
      qrCodePath: json['qrCodePath'] as String?,
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
