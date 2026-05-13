import 'stock.dart';

class Product {
  final String id;
  final String sku;
  final String productName;
  final String barcode;
  final String unitOfMeasure;
  final List<Stock>? stocks;

  Product({
    required this.id,
    required this.sku,
    required this.productName,
    required this.barcode,
    required this.unitOfMeasure,
    this.stocks,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      sku: (json['sku'] ?? json['SKU']) as String? ?? '',
      productName: json['productName'] as String? ?? '',
      barcode: json['barcode'] as String? ?? '',
      unitOfMeasure: json['unitOfMeasure'] as String? ?? '',
      stocks: (json['stock'] ?? json['stocks']) != null
          ? ((json['stock'] ?? json['stocks']) as List)
                .map((stock) => Stock.fromJson(stock as Map<String, dynamic>))
                .toList()
          : null,
    );
  }
}
