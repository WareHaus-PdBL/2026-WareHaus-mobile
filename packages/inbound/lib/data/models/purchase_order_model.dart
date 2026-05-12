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
    required super.progressCurrent,
    required super.progressTotal
  });

  factory PurchaseOrderModel.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List? ?? [])
        .map((item) => POItemModel.fromJson(item))
        .toList();

    return PurchaseOrderModel(
      id: json['id'] as int,
      poNumber: json['poNumber'] as String? ?? '',
      supplierName: json['supplierName'] as String? ?? '',
      status: json['status'] as String? ?? '',
      orderDate: json['orderDate'] != null
          ? DateTime.parse(json['orderDate'])
          : DateTime.now(),
      items: items,
      progressCurrent: json['progressCurrent'] as int?,
      progressTotal: json['progressTotal'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'poNumber': poNumber,
    'supplierName': supplierName,
    'status': status,
    'orderDate': orderDate.toIso8601String(),
    'items': items.map((e) => (e as POItemModel).toJson()).toList(),
  };
}