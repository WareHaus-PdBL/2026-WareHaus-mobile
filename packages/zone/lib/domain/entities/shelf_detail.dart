class ShelfDetail {
  final int id;
  final String shelfCode;
  final int aisle;
  final int capacity;
  final int currentVolume;
  final String qrCodePath;
  final List<ShelfStock> stocks;

  const ShelfDetail({
    required this.id,
    required this.shelfCode,
    required this.aisle,
    required this.capacity,
    required this.currentVolume,
    required this.qrCodePath,
    required this.stocks,
  });
}

class ShelfStock {
  final int id;
  final int shelfId;
  final int productId;
  final int quantity;
  final ShelfProduct product;

  const ShelfStock({
    required this.id,
    required this.shelfId,
    required this.productId,
    required this.quantity,
    required this.product,
  });
}

class ShelfProduct {
  final int id;
  final String sku;
  final String productName;
  final String barcode;
  final String unitOfMeasure;
  final int currentStock;

  const ShelfProduct({
    required this.id,
    required this.sku,
    required this.productName,
    required this.barcode,
    required this.unitOfMeasure,
    required this.currentStock,
  });
}
