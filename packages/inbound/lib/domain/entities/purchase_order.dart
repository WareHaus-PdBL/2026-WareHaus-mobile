import 'purchase_order_item.dart';

class PurchaseOrder {
  final int id;
  final String poNumber;
  final String supplierName;
  final String status;
  final List<PurchaseOrderItem> items;

  const PurchaseOrder({
    required this.id,
    required this.poNumber,
    required this.supplierName,
    required this.status,
    required this.items,
  });
}