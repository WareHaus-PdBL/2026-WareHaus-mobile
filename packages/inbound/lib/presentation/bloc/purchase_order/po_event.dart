import '../../../domain/entities/purchase_order_item.dart';

abstract class POEvent {}

class LoadPOList extends POEvent {}

class LoadPODetails extends POEvent {
  final int id;
  LoadPODetails(this.id);
}

class SubmitNewPO extends POEvent {
  final String? poNumber;
  final String supplierName;
  final List<PurchaseOrderItem> items;

  SubmitNewPO({
    this.poNumber,
    required this.supplierName,
    required this.items,
  });
}