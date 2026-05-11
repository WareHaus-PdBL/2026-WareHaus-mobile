import '../../domain/entities/purchase_order.dart';
import '../../domain/entities/purchase_order_item.dart';
import '../../domain/repositories/purchase_order_repository.dart';
import '../datasources/purchase_order_api_datasource.dart';

class PORepositoryImpl implements PORepository {
  // Inject Datasource
  final POApiDatasource remoteDatasource;

  PORepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<PurchaseOrder>> getPurchaseOrders() async {
    // Memanggil API get semua PO, otomatis dianggap sah sebagai List<PurchaseOrder>
    return await remoteDatasource.getAllPOs();
  }

  @override
  Future<PurchaseOrder> getPODetails(int id) async {
    return await remoteDatasource.getPODetails(id);
  }

  @override
  Future<PurchaseOrder> createPurchaseOrder({
    String? poNumber,
    required String supplierName,
    required List<PurchaseOrderItem> items,
  }) async {
    return await remoteDatasource.createPO(
      poNumber: poNumber,
      supplierName: supplierName,
      items: items,
    );
  }

  @override
  Future<PurchaseOrder> updatePOStatus(int id, String status) async {
    return await remoteDatasource.updatePOStatus(id, status);
  }

  @override
  Future<void> deletePO(int id) async {
    return await remoteDatasource.deletePO(id);
  }
}