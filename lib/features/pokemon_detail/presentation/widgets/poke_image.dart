import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/features/pokemon_detail/domain/entities/pokemon_detail.dart';
import 'package:pokeapp/features/pokemon_detail/presentation/widgets/detail/detail_component.dart';

class PokeImageWidget extends StatelessWidget {
  const PokeImageWidget({super.key, required this.pokemon});

  final PokemonDetail pokemon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Hero(
        tag: pokemon.id,
        child: CachedNetworkImage(
          imageUrl: pokemon.imageUrl,
          height: pokemonImageSize,
          fit: BoxFit.contain,
          placeholder: (context, url) => SizedBox(height: pokemonImageSize),
        ),
      ),
    );
  }
}
