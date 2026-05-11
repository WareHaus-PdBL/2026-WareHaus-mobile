import '../entities/purchase_order.dart';
import '../repositories/purchase_order_repository.dart';

class GetPODetails {
  final PORepository repository;

  GetPODetails(this.repository);

  Future<PurchaseOrder> call(int id) async {
    return await repository.getPODetails(id);
  }
}