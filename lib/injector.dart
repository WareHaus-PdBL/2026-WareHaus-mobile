import 'package:core_services/api/api_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:zone/presentation/bloc/zone_bloc.dart';
import 'package:zone/zone.dart';

final getIt = GetIt.instance;

void setupInjector() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<Dio>(() => getIt<ApiClient>().dio);

  getIt.registerLazySingleton<ZoneApiDatasource>(
    () => ZoneApiDatasource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ZoneRepositoryImpl>(
    () => ZoneRepositoryImpl(getIt<ZoneApiDatasource>()),
  );

  // Use Case
  getIt.registerLazySingleton(() => GetZones(getIt<ZoneRepositoryImpl>()));
  getIt.registerLazySingleton(
    () => GetZoneDetails(getIt<ZoneRepositoryImpl>()),
  );
  getIt.registerLazySingleton(() => CreateZone(getIt<ZoneRepositoryImpl>()));
  getIt.registerLazySingleton(() => UpdateZone(getIt<ZoneRepositoryImpl>()));
  getIt.registerLazySingleton(() => DeleteZone(getIt<ZoneRepositoryImpl>()));

  // ZoneBloc Factory
  getIt.registerFactory(
    () => ZoneBloc(
      getZonesUsecase: getIt<GetZones>(),
      getZoneDetailsUsecase: getIt<GetZoneDetails>(),
      createZoneUsecase: getIt<CreateZone>(),
      updateZoneUsecase: getIt<UpdateZone>(),
      deleteZoneUsecase: getIt<DeleteZone>(),
    ),
  );
}
