import 'stock.dart';

class Product {
  final String id;
  final String sku;
  final String productName;
  final String barcode;
  final String unitOfMeasure;
  final int currentStock;
  final List<Stock>? stocks;

  Product({
    required this.id,
    required this.sku,
    required this.productName,
    required this.barcode,
    required this.unitOfMeasure,
    this.currentStock = 0,
    this.stocks,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final stockValues = json['stocks'] ?? json['stock'];
    final stocks = stockValues != null
        ? (stockValues as List)
              .map((stock) => Stock.fromJson(stock as Map<String, dynamic>))
              .toList()
        : null;

    final derivedCurrentStock =
        json['currentStock'] as int? ??
        (stocks == null
            ? 0
            : stocks.fold<int>(0, (sum, stock) => sum + stock.quantity));

    return Product(
      id: json['id']?.toString() ?? '',
      sku: (json['sku'] ?? json['SKU']) as String? ?? '',
      productName: json['productName'] as String? ?? '',
      barcode: json['barcode'] as String? ?? '',
      unitOfMeasure: json['unitOfMeasure'] as String? ?? '',
      currentStock: derivedCurrentStock,
      stocks: stocks,
    );
  }
}
