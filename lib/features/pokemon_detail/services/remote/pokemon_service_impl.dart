import 'package:pokeapp/core/app/config/env.dart';
import 'package:pokeapp/core/error/failures.dart';
import 'package:pokeapp/core/network/http_client/dio_http_client.dart'
    show DioHttpClient;

import 'package:pokeapp/features/pokemon_detail/services/models/pokemon_detail_model.dart';
import 'package:pokeapp/features/pokemon_detail/services/pokemon_detail_service.dart';
import 'package:pokeapp/features/pokemon_detail/domain/entities/pokemon_detail.dart';
import 'package:pokeapp/features/pokemon_detail/services/utils/evolution_parser.dart';

class PokemonDetailServiceImpl implements PokemonDetailService {
  PokemonDetailServiceImpl({required DioHttpClient dio, String? baseUrl})
    : _dio = dio,
      _baseUrl = baseUrl ?? Env.instance.baseUrl;

  final DioHttpClient _dio;

  final String _baseUrl;

  final String _version = '/api/v2';

  @override
  Future<(Failure?, PokemonDetailModel?)> getPokemonDetail({
    required int id,
  }) async {
    try {
      final (pokemonFailure, pokemonData) = await _dio
          .get<Map<String, dynamic>>(
            '$_baseUrl/$_version/pokemon/$id',
            parser: (data) => data as Map<String, dynamic>,
          );

      if (pokemonFailure != null || pokemonData == null) {
        return (
          pokemonFailure ??
              Failure.unknownFailure(message: 'Failed to load pokemon'),
          null,
        );
      }

      final speciesUrl = pokemonData['species']['url'];

      final (speciesFailure, speciesData) = await _dio
          .get<Map<String, dynamic>>(
            speciesUrl,
            parser: (data) => data as Map<String, dynamic>,
          );

      if (speciesFailure != null || speciesData == null) {
        return (
          speciesFailure ??
              Failure.unknownFailure(message: 'Failed to load species'),
          null,
        );
      }

      final evolutionChainUrl = speciesData['evolution_chain']['url'];

      final (evolutionFailure, evolutionData) = await _dio
          .get<Map<String, dynamic>>(
            evolutionChainUrl,
            parser: (data) => data as Map<String, dynamic>,
          );

      List<Chain> evolutions = [];
      if (evolutionFailure == null && evolutionData != null) {
        evolutions = EvolutionParser.parse(evolutionData);
      }

      final pokemonModel = PokemonDetailModel.fromJson(
        pokemonData,
        evolutions: evolutions,
      );

      return (null, pokemonModel);
    } catch (e) {
      return (Failure.unknownFailure(message: e.toString()), null);
    }
  }
}
