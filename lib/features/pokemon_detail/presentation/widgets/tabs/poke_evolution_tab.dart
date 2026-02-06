import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/features/pokemon_detail/domain/entities/pokemon_detail.dart';

class PokeEvolutionTab extends StatelessWidget {
  const PokeEvolutionTab({super.key, required this.pokemon});
  final PokemonDetail pokemon;

  @override
  Widget build(BuildContext context) {
    if (pokemon.evolutions.isEmpty) {
      return const Center(child: Text('No evolution data available'));
    }
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 20,
        runSpacing: 20,
        children: pokemon.evolutions
            .map((chain) => _EvolutionItem(chain: chain))
            .toList(),
      ),
    );
  }
}

class _EvolutionItem extends StatelessWidget {
  const _EvolutionItem({required this.chain});
  final Chain chain;

  static const double imageSize = 80;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: chain.imageUrl,
          height: imageSize,
          width: imageSize,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        const SizedBox(height: 8),
        Text(
          chain.name.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }
}
