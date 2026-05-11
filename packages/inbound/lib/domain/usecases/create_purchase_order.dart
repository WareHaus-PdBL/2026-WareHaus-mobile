import '../entities/purchase_order.dart';
import '../entities/purchase_order_item.dart';
import '../repositories/purchase_order_repository.dart';

class CreatePurchaseOrder {
  final PORepository repository;

  CreatePurchaseOrder(this.repository);

  Future<PurchaseOrder> call({
    String? poNumber,
    required String supplierName,
    required List<PurchaseOrderItem> items,
  }) async {
    return await repository.createPurchaseOrder(
      poNumber: poNumber,
      supplierName: supplierName,
      items: items,
    );
  }
}