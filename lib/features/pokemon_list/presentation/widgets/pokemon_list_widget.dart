import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/features/pokemon_list/domain/entities/pokemon.dart';
import 'package:pokeapp/features/pokemon_list/presentation/widgets/pokemon_card.dart';
import '../cubit/pokemon_list_cubit.dart';

class PokemonListWidget extends StatefulWidget {
  const PokemonListWidget({
    super.key,
    required this.pokemonList,
    required this.isLoading,
  });

  final List<Pokemon> pokemonList;
  final bool isLoading;

  @override
  State<PokemonListWidget> createState() => _PokemonListWidgetState();
}

class _PokemonListWidgetState extends State<PokemonListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PokemonListCubit>().loadPokemonList();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pokemonList.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/shadow_pokemon_error.png',
            height: 300,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 24),
          Text(
            'Pokemons not found',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF433066),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<PokemonListCubit>().loadPokemonList();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: widget.pokemonList.length + (widget.isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= widget.pokemonList.length) {
          return const Center(child: CircularProgressIndicator());
        }
        return PokemonCard(pokemon: widget.pokemonList[index]);
      },
    );
  }
}
