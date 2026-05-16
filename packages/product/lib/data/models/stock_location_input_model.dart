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
