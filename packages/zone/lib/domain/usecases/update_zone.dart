import 'package:zone/domain/entities/zone.dart';
import 'package:zone/domain/repositories/zone_repository.dart';

class UpdateZone {
  final ZoneRepository repository;
  UpdateZone(this.repository);

  Future<void> call(Zone zone) {
    return repository.updateZone(zone);
  }
}
