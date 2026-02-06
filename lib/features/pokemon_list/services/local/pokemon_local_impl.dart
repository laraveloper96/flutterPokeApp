import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokeapp/core/error/failures.dart';
import 'package:pokeapp/core/shared/data/adapter/cache_response_adapter.dart';
import 'package:pokeapp/features/pokemon_list/services/models/pokemon_model.dart';
import 'package:pokeapp/features/pokemon_list/services/pokemon_service.dart';

const String cachedPokemonListKey = 'CACHED_POKEMON_LIST';

class PokemonLocalImpl implements PokemonLocalService {
  PokemonLocalImpl({required this.box});

  final Box box;

  @override
  Future<(Failure?, void)> cachePokemonList(
    List<PokemonModel> pokemonList,
  ) async {
    try {
      final List<Map<String, dynamic>> jsonList = pokemonList
          .map((model) => model.toJson())
          .toList();

      List<dynamic> currentCache = box.get(
        cachedPokemonListKey,
        defaultValue: [],
      );
      // Create a Set of IDs to avoid duplicates
      final existingIds = currentCache.map((e) => e['id']).toSet();

      for (var item in jsonList) {
        if (!existingIds.contains(item['id'])) {
          currentCache.add(item);
        }
      }

      // Sort by ID to be safe
      currentCache.sort((a, b) => (a['id'] as int).compareTo(b['id'] as int));

      await box.put(cachedPokemonListKey, currentCache);
      return (null, null);
    } catch (e) {
      return (Failure.cacheFailure(message: e.toString()), null);
    }
  }

  @override
  Future<(Failure?, List<PokemonModel>?)> getPokemonList({
    int? offset,
    int? limit,
  }) async {
    try {
      return CacheResponseAdapter<List<PokemonModel>>().call(() {
        final jsonStringList = box.get(cachedPokemonListKey);
        if (jsonStringList != null) {
          final List<dynamic> decoded = jsonStringList;
          return decoded
              .map(
                (e) => PokemonModel.fromCacheJson(Map<String, dynamic>.from(e)),
              )
              .toList();
        }

        return <PokemonModel>[];
      });
    } catch (e) {
      return (Failure.cacheFailure(message: e.toString()), null);
    }
  }
}
