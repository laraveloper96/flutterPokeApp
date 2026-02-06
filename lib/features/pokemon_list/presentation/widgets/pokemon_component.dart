import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/core/shared/presentation/widgets/app_error_view.dart';
import 'package:pokeapp/features/pokemon_list/domain/entities/pokemon.dart';
import 'package:pokeapp/features/pokemon_list/presentation/cubit/pokemon_list_cubit.dart';
import 'package:pokeapp/features/pokemon_list/presentation/widgets/poke_app_bar.dart';
import 'package:pokeapp/features/pokemon_list/presentation/widgets/pokemon_list_widget.dart';

class PokemonComponent extends StatefulWidget {
  const PokemonComponent({super.key});

  @override
  State<PokemonComponent> createState() => _PokemonComponentState();
}

class _PokemonComponentState extends State<PokemonComponent> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PokeAppBar(
        searchController: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
          });
        },
      ),
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<PokemonListCubit, PokemonListState>(
          builder: (context, state) {
            if (state is PokemonListLoading && state.isFirstFetch) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PokemonListLoaded ||
                (state is PokemonListLoading && !state.isFirstFetch)) {
              List<Pokemon> pokemonList = [];
              bool isLoadingMore = false;

              if (state is PokemonListLoading) {
                pokemonList = state.oldPokemonList;
                isLoadingMore = true;
              } else if (state is PokemonListLoaded) {
                pokemonList = state.pokemonList;
              }

              final filteredList = pokemonList
                  .where(
                    (pokemon) =>
                        pokemon.name.toLowerCase().contains(_searchQuery) ||
                        pokemon.id.toString().contains(_searchQuery),
                  )
                  .toList();

              return PokemonListWidget(
                pokemonList: filteredList,
                isLoading: isLoadingMore && _searchQuery.isEmpty,
              );
            }
            if (state is PokemonListError) {
              return AppErrorView(
                error: state.message,
                onRetry: () {
                  context.read<PokemonListCubit>().loadPokemonList();
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
