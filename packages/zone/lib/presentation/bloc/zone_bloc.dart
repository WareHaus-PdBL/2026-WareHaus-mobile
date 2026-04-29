import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone/domain/entities/zone.dart';
import 'package:zone/domain/usecases/create_zone.dart';
import 'package:zone/domain/usecases/delete_zone.dart';
import 'package:zone/domain/usecases/get_zone_details.dart';
import 'package:zone/domain/usecases/get_zones.dart';
import 'package:zone/domain/usecases/update_zone.dart';
import 'package:zone/presentation/bloc/zone_event.dart';
import 'package:zone/presentation/bloc/zone_state.dart';

class ZoneBloc extends Bloc<ZoneEvent, ZoneState> {
  final GetZones getZonesUsecase;
  final GetZoneDetails getZoneDetailsUsecase;
  final CreateZone createZoneUsecase;
  final UpdateZone updateZoneUsecase;
  final DeleteZone deleteZoneUsecase;

  ZoneBloc({
    required this.getZonesUsecase,
    required this.createZoneUsecase,
    required this.updateZoneUsecase,
    required this.deleteZoneUsecase,
    required this.getZoneDetailsUsecase,
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
    on<GetZoneDetailsEvent>((event, emit) async {
      emit(ZoneLoading());
      try {
        final zone = await getZoneDetailsUsecase(event.zoneId);
        emit(ZoneLoaded([zone]));
      } catch (e) {
        emit(ZoneError(e.toString()));
      }
    });
    on<CreateZoneEvent>((event, emit) async {
      emit(ZoneLoading());
      try {
        final zone = Zone(
          id: '',
          zoneCode: '',
          zoneName: event.zoneName,
          category: '',
          totalAisles: 0,
          totalShelves: 0,
          shelvesCapacity: 0,
          bins: const [],
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
        final current = await getZoneDetailsUsecase(event.id);
        final updatedZone = Zone(
          id: current.id,
          zoneCode: current.zoneCode,
          zoneName: event.zoneName,
          category: current.category,
          totalAisles: current.totalAisles,
          totalShelves: current.totalShelves,
          shelvesCapacity: current.shelvesCapacity,
          bins: current.bins,
        );
        await updateZoneUsecase(updatedZone);
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
