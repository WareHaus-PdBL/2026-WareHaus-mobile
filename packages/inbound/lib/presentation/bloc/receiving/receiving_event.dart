abstract class ReceivingEvent {}

// Event ini akan dipanggil saat tombol "Kirim QC" ditekan
class SubmitQCAndGetSuggestion extends ReceivingEvent {
  final int poItemId;
  final int qtyReceived; 
  final String condition; // Default: 'GOOD' untuk memicu penambahan stok
  final DateTime expiryDate;
  final String? photoUrl;

  SubmitQCAndGetSuggestion({
    required this.poItemId,
    required this.qtyReceived,
    required this.condition,
    required this.expiryDate,
    this.photoUrl,
  });
}