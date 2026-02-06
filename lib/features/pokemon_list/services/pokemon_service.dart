import 'package:pokeapp/core/error/failures.dart';
import 'package:pokeapp/features/pokemon_list/services/models/pokemon_model.dart';

abstract interface class PokemonService {
  Future<(Failure?, List<PokemonModel>?)> getPokemonList({
    int? offset,
    int? limit,
  });
}

abstract interface class PokemonLocalService implements PokemonService {
  Future<(Failure?, void)> cachePokemonList(List<PokemonModel> pokemonList);
}
