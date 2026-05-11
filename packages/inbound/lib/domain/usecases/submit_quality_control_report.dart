import '../entities/receiving_log.dart';
import '../repositories/receiving_repository.dart';

class SubmitQCReport {
  final ReceivingRepository repository;

  SubmitQCReport(this.repository);

  Future<ReceivingLog> call({
    required int poItemId,
    required int qtyReceived,
    required String condition,
    required DateTime expiryDate,
    String? photoUrl,
  }) async {
    return await repository.receiveItem(
      poItemId: poItemId,
      qtyReceived: qtyReceived,
      condition: condition,
      expiryDate: expiryDate,
      photoUrl: photoUrl,
    );
  }
}