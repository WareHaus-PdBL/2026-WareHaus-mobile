import 'package:zone/domain/repositories/zone_repository.dart';

import '../entities/zone.dart';

class GetZoneDetails {
  final ZoneRepository repository;
  GetZoneDetails(this.repository);

  Future<Zone> call(String id) {
    return repository.getZoneDetails(id);
  }
}
