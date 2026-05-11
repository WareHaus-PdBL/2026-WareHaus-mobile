import 'package:dio/dio.dart';
import '../models/receiving_log_model.dart';

abstract class ReceivingApiDatasource {
  Future<ReceivingLogModel> receiveItem({
    required int poItemId,
    required int qtyReceived,
    required String condition,
    required DateTime expiryDate,
    String? photoUrl,
  });
  Future<List<ReceivingLogModel>> getAllLogs();
  Future<List<ReceivingLogModel>> getLogsByPOItem(int poItemId);
}

class ReceivingApiDatasourceImpl implements ReceivingApiDatasource {
  final Dio dio;

  ReceivingApiDatasourceImpl({required this.dio});

  @override
  Future<ReceivingLogModel> receiveItem({
    required int poItemId,
    required int qtyReceived,
    required String condition,
    required DateTime expiryDate,
    String? photoUrl,
  }) async {
    // Mapping data agar sesuai dengan CreateReceivingDto di C#
    final payload = {
      "poItemId": poItemId,
      "qtyReceived": qtyReceived,
      "condition": condition,
      "expiryDate": expiryDate.toIso8601String(), // Ubah format tanggal ke standar ISO
      "photoUrl": photoUrl,
    };

    final response = await dio.post('/api/Receiving', data: payload);
    return ReceivingLogModel.fromJson(response.data);
  }

  @override
  Future<List<ReceivingLogModel>> getAllLogs() async {
    final response = await dio.get('/api/Receiving');
    return (response.data as List)
        .map((json) => ReceivingLogModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<ReceivingLogModel>> getLogsByPOItem(int poItemId) async {
    final response = await dio.get('/api/Receiving/poitem/$poItemId');
    return (response.data as List)
        .map((json) => ReceivingLogModel.fromJson(json))
        .toList();
  }
}