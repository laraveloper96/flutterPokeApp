import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokeapp/core/error/failures.dart';

import 'package:pokeapp/core/shared/data/adapter/cache_response_adapter.dart';
import 'package:pokeapp/features/pokemon_detail/services/models/pokemon_detail_model.dart';
import 'package:pokeapp/features/pokemon_detail/services/pokemon_detail_service.dart';

class PokemonDetailLocalImpl implements PokemonDetailLocalService {
  PokemonDetailLocalImpl({required this.box});

  final Box box;

  @override
  Future<(Failure?, PokemonDetailModel?)> getPokemonDetail({
    required int id,
  }) async {
    try {
      return CacheResponseAdapter<PokemonDetailModel>().call(() {
        final jsonString = box.get(id);
        if (jsonString != null) {
          return PokemonDetailModel.fromCacheJson(
            Map<String, dynamic>.from(jsonString),
          );
        }
        return null;
      });
    } catch (e) {
      return (Failure.unknownFailure(message: e.toString()), null);
    }
  }

  @override
  Future<void> cachePokemonDetail(PokemonDetailModel pokemon) async {
    try {
      await box.put(pokemon.id, pokemon.toJson());
    } catch (e) {
      throw Failure.cacheFailure(message: e.toString());
    }
  }
}
