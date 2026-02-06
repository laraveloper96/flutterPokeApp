import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokeapp/features/pokemon_detail/domain/entities/pokemon_detail.dart';
import 'package:pokeapp/features/pokemon_detail/presentation/widgets/poke_image.dart';
import 'package:pokeapp/features/pokemon_detail/presentation/widgets/poke_logo.dart';

class PokeAppBarWidget extends StatelessWidget {
  const PokeAppBarWidget({super.key, required this.pokemon});

  final PokemonDetail pokemon;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320.0,
      floating: false,
      pinned: true,
      backgroundColor: pokemon.typeColor,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            PokeLogoWidget(),
            PokeImageWidget(pokemon: pokemon),
          ],
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => context.pop(),
      ),
    );
  }
}
