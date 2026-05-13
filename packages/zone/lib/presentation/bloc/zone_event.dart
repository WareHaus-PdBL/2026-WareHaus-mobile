abstract class ZoneEvent {}

class GetZonesEvent extends ZoneEvent {}

class GetZoneDetailsEvent extends ZoneEvent {
  final String zoneId;

  GetZoneDetailsEvent({required this.zoneId});
}

class CreateZoneEvent extends ZoneEvent {
  final String zoneName;

  CreateZoneEvent(this.zoneName);
}

class UpdateZoneEvent extends ZoneEvent {
  final String id;
  final String zoneName;

  UpdateZoneEvent(this.id, this.zoneName);
}

class DeleteZoneEvent extends ZoneEvent {
  final String id;

  DeleteZoneEvent(this.id);
}
