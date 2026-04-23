import 'package:dio/dio.dart';
import 'package:zone/data/models/zone_model.dart';

class ZoneApiDatasource {
  final Dio dio;
  ZoneApiDatasource(this.dio);

  // Perhatikan: Tidak ada lagi try-catch berulang!

  Future<List<ZoneModel>> getZones() async {
    final response = await dio.get('/zones');
    return (response.data as List).map((e) => ZoneModel.fromJson(e)).toList();
  }

  Future<ZoneModel?> getZoneById(String id) async {
    final response = await dio.get('/zones/$id');
    return ZoneModel.fromJson(response.data);
  }

  Future<void> createZone(ZoneModel zone) async {
    await dio.post('/zones', data: zone.toJson());
  }

  Future<void> updateZone(ZoneModel zone) async {
    await dio.put('/zones/${zone.id}', data: zone.toJson());
  }

  Future<void> deleteZone(String id) async {
    await dio.delete('/zones/$id');
  }
}
