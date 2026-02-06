import 'package:pokeapp/core/app/config/env.dart';
import 'package:pokeapp/features/pokemon_detail/domain/entities/pokemon_detail.dart';

class EvolutionParser {
  static List<Chain> parse(Map<String, dynamic> json) {
    if (json['chain'] == null) return [];

    final List<Chain> evolutions = [];
    var currentChain = json['chain'];

    while (currentChain != null) {
      final species = currentChain['species'];
      final name = species['name'];
      final url = species['url'];
      final id = _getIdFromUrl(url);
      final imageUrl = '${Env.instance.baseUrlImage}$id.png';

      evolutions.add(Chain(id: id, name: name, imageUrl: imageUrl));

      if (currentChain['evolves_to'] != null &&
          (currentChain['evolves_to'] as List).isNotEmpty) {
        currentChain = currentChain['evolves_to'][0];
      } else {
        currentChain = null;
      }
    }

    return evolutions;
  }

  static String _getIdFromUrl(String url) {
    final uri = Uri.parse(url);
    return uri.pathSegments.where((e) => e.isNotEmpty).last;
  }
}
