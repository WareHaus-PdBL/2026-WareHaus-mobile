import 'package:zone/data/datasources/zone_api_datasource.dart';
import 'package:zone/data/models/zone_model.dart';
import 'package:zone/domain/entities/zone.dart';
import 'package:zone/domain/repositories/zone_repository.dart';

class ZoneRepositoryImpl implements ZoneRepository {
  final ZoneApiDatasource apiDatasource;
  ZoneRepositoryImpl(this.apiDatasource);

  @override
  Future<List<Zone>> getZones() async {
    return await apiDatasource.getZones();
  }

  @override
  Future<Zone> getZoneDetails(String id) async {
    final zone = await apiDatasource.getZoneById(id);
    if (zone == null) {
      throw Exception('Zone with id $id not found');
    }
    return zone;
  }

  @override
  Future<void> createZone(Zone zone) async {
    await apiDatasource.createZone(zone as ZoneModel);
  }

  @override
  Future<void> updateZone(Zone zone) async {
    await apiDatasource.updateZone(zone as ZoneModel);
  }

  @override
  Future<void> deleteZone(String id) async {
    await apiDatasource.deleteZone(id);
  }
}
