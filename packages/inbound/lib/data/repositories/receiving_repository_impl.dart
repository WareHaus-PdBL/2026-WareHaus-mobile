import '../../domain/entities/receiving_log.dart';
import '../../domain/entities/put_away_suggestion.dart';
import '../../domain/repositories/receiving_repository.dart';
import '../datasources/receiving_api_datasource.dart';

class ReceivingRepositoryImpl implements ReceivingRepository {
  final ReceivingApiDatasource remoteDatasource;

  ReceivingRepositoryImpl({required this.remoteDatasource});

  @override
  Future<ReceivingLog> receiveItem({
    required int poItemId,
    required int qtyReceived,
    required String condition,
    required DateTime expiryDate,
    String? photoUrl,
  }) async {
    return await remoteDatasource.receiveItem(
      poItemId: poItemId,
      qtyReceived: qtyReceived,
      condition: condition,
      expiryDate: expiryDate,
      photoUrl: photoUrl,
    );
  }

  @override
  Future<List<ReceivingLog>> getAllLogs() async {
    return await remoteDatasource.getAllLogs();
  }

  @override
  Future<List<ReceivingLog>> getLogsByPOItem(int poItemId) async {
    return await remoteDatasource.getLogsByPOItem(poItemId);
  }

  @override
  Future<PutAwaySuggestion> getPutAwaySuggestion(int poItemId) async {
    // endpoint pencarian rak belum tersedia, kalau sudah ada taruh sini datasource untuk api-nya
    throw UnimplementedError('API Endpoint untuk algoritma Put Away belum tersedia di backend.');
  }
}