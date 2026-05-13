class Stock {
  final String id;
  final int shelfId;
  final String productId;
  final int quantity;

  Stock({
    required this.id,
    required this.shelfId,
    required this.productId,
    required this.quantity,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id']?.toString() ?? '',
      shelfId: json['shelfId'] as int? ?? 0,
      productId: json['productId'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
    );
  }
}
