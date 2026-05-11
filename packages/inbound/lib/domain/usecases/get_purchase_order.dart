import '../entities/purchase_order.dart';
import '../repositories/purchase_order_repository.dart';

class GetPurchaseOrders {
  final PORepository repository;

  GetPurchaseOrders(this.repository);

  Future<List<PurchaseOrder>> call() async {
    return await repository.getPurchaseOrders();
  }
}