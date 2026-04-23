import 'package:zone/domain/entities/zone.dart';
import 'package:zone/domain/repositories/zone_repository.dart';

class CreateZone {
  final ZoneRepository repository;
  CreateZone(this.repository);

  Future<void> call(Zone zone) {
    return repository.createZone(zone);
  }
}
