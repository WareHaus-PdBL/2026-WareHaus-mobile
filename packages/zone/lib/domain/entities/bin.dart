class Bin {
  final String id;
  final String binCode;
  final int capacity;
  final int currentVolume;
  final String qrCodePath;
  final String? zoneCode;

  Bin({
    required this.id,
    required this.binCode,
    required this.capacity,
    required this.currentVolume,
    required this.qrCodePath,
    this.zoneCode,
  });

  factory Bin.fromJson(Map<String, dynamic> json) {
    return Bin(
      id: json['id']?.toString() ?? '',
      binCode: json['binCode'] as String? ?? '',
      capacity: json['capacity'] as int? ?? 0,
      currentVolume: json['currentVolume'] as int? ?? 0,
      qrCodePath: json['qrCodePath'] as String? ?? '',
      zoneCode: json['zone']?['zoneCode'] as String? ?? '',
    );
  }
}
