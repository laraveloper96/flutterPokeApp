import 'package:flutter/material.dart';
import 'package:pokeapp/features/pokemon_detail/domain/entities/pokemon_detail.dart';

class PokeAboutTab extends StatelessWidget {
  const PokeAboutTab({super.key, required this.pokemon});
  final PokemonDetail pokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _AttributeRow(label: 'Height', value: '${pokemon.height / 10} m'),
          const SizedBox(height: 15),
          _AttributeRow(label: 'Weight', value: '${pokemon.weight / 10} kg'),
          const SizedBox(height: 15),
          _AttributeRow(
            label: 'Abilities',
            value: pokemon.abilities.join(', '),
          ),
        ],
      ),
    );
  }
}

class _AttributeRow extends StatelessWidget {
  const _AttributeRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
