import 'package:zone/domain/repositories/zone_repository.dart';

class DeleteZone {
  final ZoneRepository repository;
  DeleteZone(this.repository);

  Future<void> call(String id) {
    return repository.deleteZone(id);
  }
}
