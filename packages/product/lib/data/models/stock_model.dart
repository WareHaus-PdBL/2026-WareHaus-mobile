import 'package:product/domain/entities/stock.dart';

class StockModel extends Stock {
  StockModel({
    required String id,
    required int shelfId,
    required String productId,
    required int quantity,
  }) : super(
         id: id,
         shelfId: shelfId,
         productId: productId,
         quantity: quantity,
       );

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      id: json['id']?.toString() ?? '',
      shelfId: json['shelfId'] as int? ?? 0,
      productId: json['productId'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'shelfId': shelfId,
    'productId': productId,
    'quantity': quantity,
  };
}
