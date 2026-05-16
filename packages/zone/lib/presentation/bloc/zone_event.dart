abstract class ZoneEvent {}

class GetZonesEvent extends ZoneEvent {}

class GetZoneByAisleEvent extends ZoneEvent {
  final String zoneId;
  final int aisleNumber;

  GetZoneByAisleEvent({required this.zoneId, required this.aisleNumber});
}

class GetZoneDetailsEvent extends ZoneEvent {
  final String zoneId;

  GetZoneDetailsEvent({required this.zoneId});
}

class GetShelfDetailsEvent extends ZoneEvent {
  final int shelfId;

  GetShelfDetailsEvent({required this.shelfId});
}

class CreateZoneEvent extends ZoneEvent {
  final String zoneName;
  final String zoneCode;
  final String category;
  final int totalAisle;
  final int shelfPerAisle;
  final int capacityPerShelf;
  String? description;

  CreateZoneEvent({
    required this.zoneName,
    required this.zoneCode,
    required this.category,
    required this.totalAisle,
    required this.shelfPerAisle,
    required this.capacityPerShelf,
    this.description,
  });
}

class UpdateZoneEvent extends ZoneEvent {
  final String id;
  final String? zoneName;
  final String? category;
  final String? description;

  UpdateZoneEvent({
    required this.id,
    this.zoneName,
    this.category,
    this.description,
  });
}

class DeleteZoneEvent extends ZoneEvent {
  final String id;

  DeleteZoneEvent(this.id);
}
