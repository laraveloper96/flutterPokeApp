import '../../domain/entities/pokemon_detail.dart';

class PokemonDetailModel extends PokemonDetail {
  const PokemonDetailModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.types,
    required super.height,
    required super.weight,
    required super.stats,
    super.evolutions = const [],
    super.abilities = const [],
  });

  factory PokemonDetailModel.fromJson(
    Map<String, dynamic> json, {
    List<Chain> evolutions = const [],
  }) {
    return PokemonDetailModel(
      id: json['id'],
      name: json['name'],
      imageUrl: _imageUrl(json),
      types: _types(json),
      height: json['height'],
      weight: json['weight'],
      stats: _stats(json),
      evolutions: evolutions,
      abilities: _abilities(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'types': types,
      'height': height,
      'weight': weight,
      'abilities': abilities,
      'stats': stats
          .map((s) => {'name': s.name, 'baseStat': s.baseStat})
          .toList(),
      'evolutions': evolutions
          .map((e) => {'id': e.id, 'name': e.name, 'imageUrl': e.imageUrl})
          .toList(),
    };
  }

  factory PokemonDetailModel.fromCacheJson(Map<String, dynamic> json) {
    return PokemonDetailModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      types: List<String>.from(json['types']),
      height: json['height'],
      weight: json['weight'],
      stats: (json['stats'] as List)
          .map((s) => Stat(name: s['name'], baseStat: s['baseStat']))
          .toList(),
      evolutions: json['evolutions'] != null
          ? (json['evolutions'] as List)
                .map(
                  (e) => Chain(
                    id: e['id'],
                    name: e['name'],
                    imageUrl: e['imageUrl'],
                  ),
                )
                .toList()
          : [],
      abilities: json['abilities'] != null
          ? List<String>.from(json['abilities'])
          : [],
    );
  }

  static String _imageUrl(Map<String, dynamic> json) =>
      json['sprites']['other']['official-artwork']['front_default'] ??
      json['sprites']['front_default'] ??
      '';

  static List<String> _types(Map<String, dynamic> json) =>
      (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList();

  static List<Stat> _stats(Map<String, dynamic> json) => (json['stats'] as List)
      .map(
        (stat) => Stat(name: stat['stat']['name'], baseStat: stat['base_stat']),
      )
      .toList();

  static List<String> _abilities(Map<String, dynamic> json) =>
      (json['abilities'] as List?)
          ?.map((ability) => ability['ability']['name'] as String)
          .toList() ??
      [];
}
