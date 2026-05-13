import 'package:dio/dio.dart';
import 'package:zone/data/models/zone_model.dart';

class ZoneApiDatasource {
  final Dio dio;
  ZoneApiDatasource(this.dio);

  static const String _zonePath = '/Zone';

  // Perhatikan: Tidak ada lagi try-catch berulang!

  Future<List<ZoneModel>> getZones() async {
    final response = await dio.get(_zonePath);
    return (response.data as List).map((e) => ZoneModel.fromJson(e)).toList();
  }

  Future<ZoneModel?> getZoneById(String id) async {
    final response = await dio.get('$_zonePath/$id');
    return ZoneModel.fromJson(response.data);
  }

  Future<void> createZone(ZoneModel zone) async {
    await dio.post(_zonePath, data: zone.toJson());
  }

  Future<void> updateZone(ZoneModel zone) async {
    await dio.put('$_zonePath/${zone.id}', data: zone.toJson());
  }

  Future<void> deleteZone(String id) async {
    await dio.delete('$_zonePath/$id');
  }
}
