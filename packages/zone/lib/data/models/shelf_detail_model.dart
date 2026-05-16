import 'package:zone/domain/entities/shelf_detail.dart';

class ShelfDetailModel extends ShelfDetail {
  ShelfDetailModel({
    required super.id,
    required super.shelfCode,
    required super.aisle,
    required super.capacity,
    required super.currentVolume,
    required super.qrCodePath,
    required super.stocks,
  });

  factory ShelfDetailModel.fromJson(Map<String, dynamic> json) {
    return ShelfDetailModel(
      id: json['id'] as int? ?? 0,
      shelfCode: json['shelfCode'] as String? ?? '',
      aisle: json['aisle'] as int? ?? 0,
      capacity: json['capacity'] as int? ?? 0,
      currentVolume: json['currentVolume'] as int? ?? 0,
      qrCodePath: json['qrCodePath'] as String? ?? '',
      stocks: ((json['stocks'] as List?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(ShelfStockModel.fromJson)
          .toList(),
    );
  }
}

class ShelfStockModel extends ShelfStock {
  ShelfStockModel({
    required super.id,
    required super.shelfId,
    required super.productId,
    required super.quantity,
    required super.product,
  });

  factory ShelfStockModel.fromJson(Map<String, dynamic> json) {
    return ShelfStockModel(
      id: json['id'] as int? ?? 0,
      shelfId: json['shelfId'] as int? ?? 0,
      productId: json['productId'] as int? ?? 0,
      quantity: json['quantity'] as int? ?? 0,
      product: ShelfProductModel.fromJson(
        (json['product'] as Map?)?.cast<String, dynamic>() ?? const {},
      ),
    );
  }
}

class ShelfProductModel extends ShelfProduct {
  ShelfProductModel({
    required super.id,
    required super.sku,
    required super.productName,
    required super.barcode,
    required super.unitOfMeasure,
    required super.currentStock,
  });

  factory ShelfProductModel.fromJson(Map<String, dynamic> json) {
    return ShelfProductModel(
      id: json['id'] as int? ?? 0,
      sku: json['sku'] as String? ?? '',
      productName: json['productName'] as String? ?? '',
      barcode: json['barcode'] as String? ?? '',
      unitOfMeasure: json['unitOfMeasure'] as String? ?? '',
      currentStock: json['currentStock'] as int? ?? 0,
    );
  }
}
