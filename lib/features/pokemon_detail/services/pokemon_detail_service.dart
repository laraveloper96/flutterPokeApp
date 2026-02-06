import 'package:pokeapp/core/error/failures.dart';
import 'package:pokeapp/features/pokemon_detail/services/models/pokemon_detail_model.dart';

abstract interface class PokemonDetailService {
  Future<(Failure?, PokemonDetailModel?)> getPokemonDetail({required int id});
}

abstract interface class PokemonDetailLocalService
    implements PokemonDetailService {
  Future<void> cachePokemonDetail(PokemonDetailModel pokemon);
}
