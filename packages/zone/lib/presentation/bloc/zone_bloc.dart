import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone/domain/entities/zone.dart';
import 'package:zone/domain/usecases/create_zone.dart';
import 'package:zone/domain/usecases/delete_zone.dart';
import 'package:zone/domain/usecases/get_shelf_details.dart';
import 'package:zone/domain/usecases/get_zone_by_aisle.dart';
import 'package:zone/domain/usecases/get_zone_details.dart';
import 'package:zone/domain/usecases/get_zones.dart';
import 'package:zone/domain/usecases/update_zone.dart';
import 'package:zone/presentation/bloc/zone_event.dart';
import 'package:zone/presentation/bloc/zone_state.dart';

class ZoneBloc extends Bloc<ZoneEvent, ZoneState> {
  final GetZones getZonesUsecase;
  final GetZoneByAisle getZoneByAisleUsecase;
  final GetZoneDetails getZoneDetailsUsecase;
  final GetShelfDetails getShelfDetailsUsecase;
  final CreateZone createZoneUsecase;
  final UpdateZone updateZoneUsecase;
  final DeleteZone deleteZoneUsecase;

  ZoneBloc({
    required this.getZonesUsecase,
    required this.getZoneByAisleUsecase,
    required this.createZoneUsecase,
    required this.updateZoneUsecase,
    required this.deleteZoneUsecase,
    required this.getZoneDetailsUsecase,
    required this.getShelfDetailsUsecase,
  }) : super(ZoneInitial()) {
    on<GetZonesEvent>((event, emit) async {
      emit(ZoneLoading());
      try {
        final zones = await getZonesUsecase();
        emit(ZoneLoaded(zones));
      } catch (e) {
        emit(ZoneError(e.toString()));
      }
    });
    on<GetZoneByAisleEvent>((event, emit) async {
      emit(ZoneLoading());
      try {
        final zones = await getZoneByAisleUsecase(
          event.zoneId,
          event.aisleNumber,
        );
        emit(ZoneLoaded(zones));
      } catch (e) {
        emit(ZoneError(e.toString()));
      }
    });
    on<GetZoneDetailsEvent>((event, emit) async {
      emit(ZoneLoading());
      try {
        final zone = await getZoneDetailsUsecase(event.zoneId);
        emit(ZoneLoaded([zone]));
      } catch (e) {
        emit(ZoneError(e.toString()));
      }
    });
    on<GetShelfDetailsEvent>((event, emit) async {
      emit(ZoneLoading());
      try {
        final shelfDetail = await getShelfDetailsUsecase(event.shelfId);
        emit(
          ShelfDetailLoaded(shelfId: event.shelfId, shelfDetail: shelfDetail),
        );
      } catch (e) {
        emit(ZoneError(e.toString()));
      }
    });
    on<CreateZoneEvent>((event, emit) async {
      emit(ZoneLoading());
      try {
        final zone = Zone(
          id: '',
          zoneCode: event.zoneCode,
          zoneName: event.zoneName,
          category: event.category,
          description: event.description ?? '',
          totalAisle: event.totalAisle,
          shelfPerAisle: event.shelfPerAisle,
          capacityPerShelf: event.capacityPerShelf,
          shelves: const [],
        );
        await createZoneUsecase(zone);
        final zones = await getZonesUsecase();
        emit(ZoneLoaded(zones));
      } catch (e) {
        emit(ZoneError(e.toString()));
      }
    });
    on<UpdateZoneEvent>((event, emit) async {
      emit(ZoneLoading());
      try {
        await updateZoneUsecase(
          id: event.id,
          zoneName: event.zoneName,
          category: event.category,
          description: event.description,
        );
        final zones = await getZonesUsecase();
        emit(ZoneLoaded(zones));
      } catch (e) {
        emit(ZoneError(e.toString()));
      }
    });
    on<DeleteZoneEvent>((event, emit) async {
      emit(ZoneLoading());
      try {
        await deleteZoneUsecase(event.id);
        final zones = await getZonesUsecase();
        emit(ZoneLoaded(zones));
      } catch (e) {
        emit(ZoneError(e.toString()));
      }
    });
  }
}
