class StockLocationInput {
  final String productId;
  final int shelfId;
  final int quantity;

  const StockLocationInput({
    required this.productId,
    required this.shelfId,
    required this.quantity,
  });
}
