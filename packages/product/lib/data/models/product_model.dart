import 'package:product/data/models/stock_model.dart';
import 'package:product/domain/entities/product.dart';
import 'package:product/domain/entities/stock.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String sku,
    required String productName,
    required String barcode,
    required String unitOfMeasure,
    int currentStock = 0,
    List<Stock>? stocks,
  }) : super(
         id: id,
         sku: sku,
         productName: productName,
         barcode: barcode,
         unitOfMeasure: unitOfMeasure,
         currentStock: currentStock,
         stocks: stocks ?? [],
       );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final stockValues = json['stock'] ?? json['stocks'];
    final stocks = stockValues != null
        ? (stockValues as List)
              .map(
                (stock) => StockModel.fromJson(stock as Map<String, dynamic>),
              )
              .toList()
        : <Stock>[];

    return ProductModel(
      id: json['id']?.toString() ?? '',
      sku: (json['sku'] ?? json['SKU']) as String? ?? '',
      productName: json['productName'] as String? ?? '',
      barcode: json['barcode'] as String? ?? '',
      unitOfMeasure: json['unitOfMeasure'] as String? ?? '',
      currentStock:
          json['currentStock'] as int? ??
          stocks.fold<int>(0, (sum, stock) => sum + stock.quantity),
      stocks: stocks,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'sku': sku,
    'productName': productName,
    'barcode': barcode,
    'unitOfMeasure': unitOfMeasure,
    'currentStock': currentStock,
    'stocks': stocks?.map((stock) => (stock as StockModel).toJson()).toList(),
  };
}
