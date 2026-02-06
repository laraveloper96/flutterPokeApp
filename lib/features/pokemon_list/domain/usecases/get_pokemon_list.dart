import 'package:equatable/equatable.dart';
import 'package:pokeapp/core/network/network_info.dart';
import 'package:pokeapp/features/pokemon_list/services/pokemon_service.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon.dart';

class GetPokemonList implements UseCase<List<Pokemon>, GetPokemonListParams> {
  GetPokemonList({
    required this.service,
    required this.local,
    required this.networkInfo,
  });

  final PokemonService service;
  final PokemonLocalService local;
  final NetworkInfo networkInfo;

  @override
  Future<(Failure?, List<Pokemon>?)> call(GetPokemonListParams params) async {
    if (await networkInfo.isConnected) {
      final (failure, pokemonList) = await service.getPokemonList(
        offset: params.offset,
        limit: params.limit,
      );
      if (pokemonList != null) {
        local.cachePokemonList(pokemonList);
      }
      return (failure, pokemonList);
    } else {
      final (failure, localPokemon) = await local.getPokemonList(
        offset: params.offset,
        limit: params.limit,
      );

      if (failure != null) {
        return (failure, null);
      }

      try {
        if (localPokemon!.length > params.offset) {
          int end = params.offset + params.limit;
          if (end > localPokemon.length) end = localPokemon.length;
          return (null, localPokemon.sublist(params.offset, end));
        } else {
          return (null, <Pokemon>[]);
        }
      } catch (e) {
        return (Failure.unknownFailure(message: e.toString()), null);
      }
    }
  }
}

class GetPokemonListParams extends Equatable {
  final int offset;
  final int limit;

  const GetPokemonListParams({required this.offset, required this.limit});

  @override
  List<Object> get props => [offset, limit];
}
