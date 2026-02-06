import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pokeapp/core/network/http_client/dio_http_client.dart';
import 'package:pokeapp/core/utils/constants/app_keys.dart';
import '../../features/pokemon_detail/services/pokemon_detail_service.dart';
import '../../features/pokemon_detail/services/remote/pokemon_service_impl.dart';
import '../../features/pokemon_detail/services/local/pokemon_detail_local_impl.dart';
import '../../features/pokemon_detail/domain/usecases/get_pokemon_detail.dart';
import '../../features/pokemon_detail/presentation/cubit/pokemon_detail_cubit.dart';
import '../../features/pokemon_list/services/pokemon_service.dart';
import '../../features/pokemon_list/services/remote/pokemon_service_impl.dart';
import '../../features/pokemon_list/services/local/pokemon_local_impl.dart'
    hide cachedPokemonListKey;
import '../../features/pokemon_list/domain/usecases/get_pokemon_list.dart';
import '../../features/pokemon_list/presentation/cubit/pokemon_list_cubit.dart';
import '../network/network_info.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(() => PokemonListCubit(getPokemonList: getIt()));

  getIt.registerLazySingleton(
    () =>
        GetPokemonList(service: getIt(), local: getIt(), networkInfo: getIt()),
  );

  getIt.registerLazySingleton<PokemonService>(
    () => PokemonRemoteImpl(dio: getIt()),
  );
  getIt.registerLazySingleton<PokemonLocalService>(
    () => PokemonLocalImpl(box: getIt()),
  );

  getIt.registerFactory(() => PokemonDetailCubit(getPokemonDetail: getIt()));

  // Services
  getIt.registerLazySingleton<PokemonDetailService>(
    () => PokemonDetailServiceImpl(dio: getIt()),
  );
  getIt.registerLazySingleton<PokemonDetailLocalService>(
    () => PokemonDetailLocalImpl(box: getIt(instanceName: _Keys.detailsBox)),
  );

  // Use Case
  getIt.registerLazySingleton(
    () => GetPokemonDetail(
      service: getIt(),
      local: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  // External
  await Hive.initFlutter();
  final pokemonBox = await Hive.openBox(cachedPokemonListKey);
  getIt.registerLazySingleton<Box>(() => pokemonBox);

  final detailsBox = await Hive.openBox(cachedPokemonDetailsKey);
  getIt.registerLazySingleton<Box>(
    () => detailsBox,
    instanceName: _Keys.detailsBox,
  );

  getIt.registerLazySingleton(() => DioHttpClient());
  getIt.registerLazySingleton(() => InternetConnection());
}

class _Keys {
  static const String detailsBox = 'detailsBox';
}
