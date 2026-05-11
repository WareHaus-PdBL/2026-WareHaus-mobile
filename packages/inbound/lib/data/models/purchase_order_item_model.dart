import '../../domain/entities/purchase_order_item.dart';

class POItemModel extends PurchaseOrderItem {
  const POItemModel({
    required super.id,
    required super.productId,
    required super.productName,
    required super.productSku,
    required super.qtyExpected,
  });

  factory POItemModel.fromJson(Map<String, dynamic> json) {
    return POItemModel(
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'] ?? 'Unknown Product', 
      productSku: json['productSku'],
      qtyExpected: json['qtyExpected'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productSku': productSku,
      'qtyExpected': qtyExpected,
    };
  }
}