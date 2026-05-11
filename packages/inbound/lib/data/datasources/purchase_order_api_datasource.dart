import 'package:dio/dio.dart';
import '../models/purchase_order_model.dart';
import '../../domain/entities/purchase_order_item.dart';

abstract class POApiDatasource {
  Future<List<PurchaseOrderModel>> getAllPOs();
  Future<PurchaseOrderModel> getPODetails(int id);
  Future<PurchaseOrderModel> createPO({
    String? poNumber,
    required String supplierName,
    required List<PurchaseOrderItem> items,
  });
  Future<PurchaseOrderModel> updatePOStatus(int id, String status);
  Future<void> deletePO(int id);
}

class POApiDatasourceImpl implements POApiDatasource {
  final Dio dio;

  POApiDatasourceImpl({required this.dio});

  @override
  Future<List<PurchaseOrderModel>> getAllPOs() async {
    final response = await dio.get('/api/PurchaseOrders');
    return (response.data as List)
        .map((json) => PurchaseOrderModel.fromJson(json))
        .toList();
  }

  @override
  Future<PurchaseOrderModel> getPODetails(int id) async {
    final response = await dio.get('/api/PurchaseOrders/$id');
    return PurchaseOrderModel.fromJson(response.data);
  }

  @override
  Future<PurchaseOrderModel> createPO({
    String? poNumber,
    required String supplierName,
    required List<PurchaseOrderItem> items,
  }) async {
    // Mapping data agar sesuai dengan CreatePurchaseOrderDto di C#
    final payload = {
      "poNumber": poNumber,
      "supplierName": supplierName,
      "items": items.map((e) => {
        "productId": e.productId,
        "qtyExpected": e.qtyExpected
      }).toList(),
    };

    final response = await dio.post('/api/PurchaseOrders', data: payload);
    return PurchaseOrderModel.fromJson(response.data);
  }

  @override
  Future<PurchaseOrderModel> updatePOStatus(int id, String status) async {
    // Membungkus status dalam tanda kutip karena [FromBody] string di .NET 
    // mengekspektasikan format JSON string literal
    final response = await dio.put('/api/PurchaseOrders/$id/status', data: '"$status"');
    return PurchaseOrderModel.fromJson(response.data);
  }

  @override
  Future<void> deletePO(int id) async {
    await dio.delete('/api/PurchaseOrders/$id');
  }
}