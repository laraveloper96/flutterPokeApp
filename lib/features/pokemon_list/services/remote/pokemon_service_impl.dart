import 'package:pokeapp/core/app/config/env.dart';
import 'package:pokeapp/core/error/failures.dart';
import 'package:pokeapp/core/network/http_client/dio_http_client.dart';
import 'package:pokeapp/features/pokemon_list/services/models/pokemon_model.dart';
import 'package:pokeapp/features/pokemon_list/services/pokemon_service.dart';

class PokemonRemoteImpl implements PokemonService {
  PokemonRemoteImpl({required DioHttpClient dio, String? baseUrl})
    : _dio = dio,
      _baseUrl = baseUrl ?? Env.instance.baseUrl;

  final DioHttpClient _dio;

  final String _baseUrl;

  final String _version = '/api/v2';

  @override
  Future<(Failure?, List<PokemonModel>?)> getPokemonList({
    int? offset,
    int? limit,
  }) async {
    if (offset == null || limit == null) {
      return (
        Failure.customFailure(message: 'Offset and limit are required'),
        null,
      );
    }
    try {
      return await _dio.get<List<PokemonModel>>(
        '$_baseUrl/$_version/pokemon',
        queryParameters: {'offset': offset, 'limit': limit},
        parser: (data) {
          if (data is Map<String, dynamic> && data['results'] is List) {
            final List results = data['results'];
            return results.map((json) => PokemonModel.fromJson(json)).toList();
          }
          return [];
        },
      );
    } catch (e) {
      return (Failure.unknownFailure(message: e.toString()), null);
    }
  }
}
