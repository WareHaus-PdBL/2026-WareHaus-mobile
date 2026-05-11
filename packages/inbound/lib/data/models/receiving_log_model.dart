import '../../domain/entities/receiving_log.dart';

class ReceivingLogModel extends ReceivingLog {
  const ReceivingLogModel({
    required super.id,
    required super.poItemId,
    required super.qtyReceived,
    required super.condition,
    required super.receivedAt,
    required super.expiryDate,
    super.photoUrl,
  });

  factory ReceivingLogModel.fromJson(Map<String, dynamic> json) {
    return ReceivingLogModel(
      id: json['id'],
      poItemId: json['poItemId'],
      qtyReceived: json['qtyReceived'],
      condition: json['condition'],
      receivedAt: DateTime.parse(json['receivedAt']),
      expiryDate: DateTime.parse(json['expiryDate']),
      photoUrl: json['photoUrl'],
    );
  }
}