import 'package:flutter/material.dart';
import 'package:pokeapp/features/pokemon_detail/domain/entities/pokemon_detail.dart';

class PokeStatsTab extends StatelessWidget {
  const PokeStatsTab({super.key, required this.pokemon});
  final PokemonDetail pokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: pokemon.stats.map((s) {
          final color = (s.baseStat > 50) ? Colors.green : Colors.redAccent;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    _formatStatName(s.name),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    s.baseStat.toString(),
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: LinearProgressIndicator(
                      value: s.baseStat / 100, // Normalized roughly
                      color: color,
                      backgroundColor: Colors.grey[200],
                      minHeight: 6,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  String _formatStatName(String name) {
    switch (name) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'ATK';
      case 'defense':
        return 'DEF';
      case 'special-attack':
        return 'SATK';
      case 'special-defense':
        return 'SDEF';
      case 'speed':
        return 'SPD';
      default:
        return name.toUpperCase().substring(0, 3);
    }
  }
}
