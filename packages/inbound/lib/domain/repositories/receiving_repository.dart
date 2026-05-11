import '../entities/receiving_log.dart';
import '../entities/put_away_suggestion.dart';

abstract class ReceivingRepository {
  // POST: api/Receiving
  Future<ReceivingLog> receiveItem({
    required int poItemId,
    required int qtyReceived,
    required String condition,
    required DateTime expiryDate,
    String? photoUrl,
  });

  // GET: api/Receiving
  Future<List<ReceivingLog>> getAllLogs();

  // GET: api/Receiving/poitem/{poItemId}
  Future<List<ReceivingLog>> getLogsByPOItem(int poItemId);

  // Fungsi tambahan untuk alur "Put Away" sesuai PRD-04
  // Ini akan memicu algoritma di backend/sistem untuk mencari rak kosong
  Future<PutAwaySuggestion> getPutAwaySuggestion(int poItemId);
}