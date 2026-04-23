import '../entities/zone.dart';

abstract class ZoneRepository {
  Future<List<Zone>> getZones();
  Future<Zone> getZoneDetails(String id);
  Future<void> createZone(Zone zone);
  Future<void> updateZone(Zone zone);
  Future<void> deleteZone(String id);
}
