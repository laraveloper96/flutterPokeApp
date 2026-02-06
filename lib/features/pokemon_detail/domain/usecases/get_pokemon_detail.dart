import 'package:equatable/equatable.dart';
import 'package:pokeapp/core/network/network_info.dart';
import 'package:pokeapp/features/pokemon_detail/services/pokemon_detail_service.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon_detail.dart';

class GetPokemonDetail
    implements UseCase<PokemonDetail, GetPokemonDetailParams> {
  final PokemonDetailService service;
  final PokemonDetailLocalService local;
  final NetworkInfo networkInfo;

  GetPokemonDetail({
    required this.service,
    required this.local,
    required this.networkInfo,
  });

  @override
  Future<(Failure?, PokemonDetail?)> call(GetPokemonDetailParams params) async {
    if (await networkInfo.isConnected) {
      final (failure, remotePokemon) = await service.getPokemonDetail(
        id: params.id,
      );
      if (failure != null) {
        return (failure, null);
      }
      await local.cachePokemonDetail(remotePokemon!);
      return (null, remotePokemon);
    } else {
      final (failure, localPokemon) = await local.getPokemonDetail(
        id: params.id,
      );
      if (failure != null) {
        return (failure, null);
      }
      return (null, localPokemon);
    }
  }
}

class GetPokemonDetailParams extends Equatable {
  final int id;

  const GetPokemonDetailParams({required this.id});

  @override
  List<Object> get props => [id];
}
