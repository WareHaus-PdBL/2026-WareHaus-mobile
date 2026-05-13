import '../entities/zone.dart';

abstract class ZoneRepository {
  Future<List<Zone>> getZones();
  Future<List<Zone>> getZonesByAisle(String zoneId, int aisleNumber);
  Future<Zone> getZoneDetails(String id);
  Future<void> createZone(Zone zone);
  Future<void> updateZone({
    required String id,
    String? zoneName,
    String? category,
    String? description,
  });
  Future<void> deleteZone(String id);
}
