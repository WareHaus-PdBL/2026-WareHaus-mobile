import 'package:product/domain/entities/stock_location_input.dart';

class StockLocationInputModel extends StockLocationInput {
  const StockLocationInputModel({
    required super.productId,
    required super.shelfId,
    required super.quantity,
  });

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'shelfId': shelfId,
    'quantity': quantity,
  };
}

class MoveStockInput {
  final String productId;
  final int fromShelfId;
  final int toShelfId;
  final int quantity;

  const MoveStockInput({
    required this.productId,
    required this.fromShelfId,
    required this.toShelfId,
    required this.quantity,
  });
}

class MoveStockInputModel extends MoveStockInput {
  const MoveStockInputModel({
    required super.productId,
    required super.fromShelfId,
    required super.toShelfId,
    required super.quantity,
  });

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'fromShelfId': fromShelfId,
    'toShelfId': toShelfId,
    'quantity': quantity,
  };
}