class ReceivingLog {
  final int id;
  final int poItemId;
  final int qtyReceived;
  final String condition;
  final DateTime receivedAt;
  final DateTime expiryDate;
  final String? photoUrl;

  const ReceivingLog({
    required this.id,
    required this.poItemId,
    required this.qtyReceived,
    required this.condition,
    required this.receivedAt,
    required this.expiryDate,
    this.photoUrl,
  });
}