import '../../domain/entities/purchase_order.dart';
import 'purchase_order_item_model.dart';

class PurchaseOrderModel extends PurchaseOrder {
  const PurchaseOrderModel({
    required super.id,
    required super.poNumber,
    required super.supplierName,
    required super.status,
    required super.orderDate,
    required super.items,
  });

  factory PurchaseOrderModel.fromJson(Map<String, dynamic> json) {
    return PurchaseOrderModel(
      id: json['id'],
      poNumber: json['poNumber'],
      supplierName: json['supplierName'],
      status: json['status'],
      orderDate: DateTime.parse(json['orderDate']),
      items: (json['items'] as List)
          .map((item) => POItemModel.fromJson(item))
          .toList(),
    );
  }
}