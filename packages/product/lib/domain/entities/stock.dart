class Stock {
  final String id;
  final int shelfId;
  final String productId;
  final int quantity;
  final String shelfCode;
  final int zoneId;
  final String zoneCode;
  final String zoneName;
  final int aisle;
  final String locationName;
  final int shelfCapacity;
  final int shelfCurrentVolume;
  final int shelfAvailableCapacity;
  final String qrCodePath;

  Stock({
    required this.id,
    required this.shelfId,
    required this.productId,
    required this.quantity,
    this.shelfCode = '',
    this.zoneId = 0,
    this.zoneCode = '',
    this.zoneName = '',
    this.aisle = 0,
    this.locationName = '',
    this.shelfCapacity = 0,
    this.shelfCurrentVolume = 0,
    this.shelfAvailableCapacity = 0,
    this.qrCodePath = '',
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id']?.toString() ?? '',
      shelfId: json['shelfId'] as int? ?? 0,
      productId: json['productId'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
      shelfCode: (json['shelfCode'] ?? json['binCode']) as String? ?? '',
      zoneId: json['zoneId'] as int? ?? 0,
      zoneCode: json['zoneCode'] as String? ?? '',
      zoneName: json['zoneName'] as String? ?? '',
      aisle: json['aisle'] as int? ?? 0,
      locationName: json['locationName'] as String? ?? '',
      shelfCapacity: json['shelfCapacity'] as int? ?? 0,
      shelfCurrentVolume: json['shelfCurrentVolume'] as int? ?? 0,
      shelfAvailableCapacity: json['shelfAvailableCapacity'] as int? ?? 0,
      qrCodePath: json['qrCodePath'] as String? ?? '',
    );
  }
}
