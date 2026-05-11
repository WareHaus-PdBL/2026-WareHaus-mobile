class PurchaseOrderItem {
  final int id;
  final int productId;
  final String productName;
  final String? productSku;
  final int qtyExpected;

  const PurchaseOrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productSku,
    required this.qtyExpected,
  });
}
