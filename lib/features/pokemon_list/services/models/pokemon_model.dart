import 'package:pokeapp/core/app/config/env.dart';

import '../../domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  const PokemonModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final id = _getId(json);

    final imageUrl = '${Env.instance.baseUrlImage}$id.png';

    return PokemonModel(
      id: id,
      name: json['name'] as String,
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'imageUrl': imageUrl};
  }

  factory PokemonModel.fromCacheJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }

  static int _getId(Map<String, dynamic> json) {
    int id = 0;
    if (json['url'] != null) {
      final urlParts = (json['url'] as String).split('/');
      id = int.tryParse(urlParts[urlParts.length - 2]) ?? 0;
    } else {
      id = json['id'] as int? ?? 0;
    }
    return id;
  }
}
