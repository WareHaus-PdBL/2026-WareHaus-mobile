import 'package:zone/domain/entities/zone.dart';
import 'package:zone/domain/entities/shelf_detail.dart';

abstract class ZoneState {}

class ZoneInitial extends ZoneState {}

class ZoneLoading extends ZoneState {}

class ZoneLoaded extends ZoneState {
  final List<Zone> zones;

  ZoneLoaded(this.zones);
}

class ZoneError extends ZoneState {
  final String message;

  ZoneError(this.message);
}

class ShelfDetailLoaded extends ZoneState {
  final int shelfId;
  final ShelfDetail shelfDetail;

  ShelfDetailLoaded({required this.shelfId, required this.shelfDetail});
}
