import '../entities/purchase_order.dart';
import '../entities/purchase_order_item.dart';

abstract class PORepository {
  // GET: api/PurchaseOrders
  Future<List<PurchaseOrder>> getPurchaseOrders();

  // GET: api/PurchaseOrders/{id}
  Future<PurchaseOrder> getPODetails(int id);

  // POST: api/PurchaseOrders
  // Kita menggunakan parameter mentah dulu, nanti di Data Layer baru diubah ke DTO
  Future<PurchaseOrder> createPurchaseOrder({
    String? poNumber,
    required String supplierName,
    required List<PurchaseOrderItem> items,
  });

  // PUT: api/PurchaseOrders/{id}/status
  Future<PurchaseOrder> updatePOStatus(int id, String status);

  // DELETE: api/PurchaseOrders/{id}
  Future<void> deletePO(int id);
}