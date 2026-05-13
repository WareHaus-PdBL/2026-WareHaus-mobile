import 'package:zone/domain/repositories/zone_repository.dart';

import '../entities/zone.dart';

class GetZones {
  final ZoneRepository repository;
  GetZones(this.repository);

  Future<List<Zone>> call() {
    return repository.getZones();
  }
}
