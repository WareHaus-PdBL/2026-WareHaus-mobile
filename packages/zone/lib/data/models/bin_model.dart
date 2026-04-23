import 'package:zone/domain/entities/bin.dart';

class BinModel extends Bin {
  BinModel({
    required String id,
    required String binCode,
    required int capacity,
    required int currentVolume,
    required String qrCodePath,
    String? zoneCode,
  }) : super(
         id: id,
         binCode: binCode,
         capacity: capacity,
         currentVolume: currentVolume,
         qrCodePath: qrCodePath,
         zoneCode: zoneCode,
       );

  factory BinModel.fromJson(Map<String, dynamic> json) {
    return BinModel(
      id: json['id']?.toString() ?? '',
      binCode: json['binCode'] as String? ?? '',
      capacity: json['capacity'] as int? ?? 0,
      currentVolume: json['currentVolume'] as int? ?? 0,
      qrCodePath: json['qrCodePath'] as String? ?? '',
      zoneCode: json['zone']?['zoneCode'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'binCode': binCode,
      'capacity': capacity,
      'currentVolume': currentVolume,
      'qrCodePath': qrCodePath,
      'zoneCode': zoneCode,
    };
  }
}
