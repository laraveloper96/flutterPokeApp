import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/core/di/service_locator.dart';
import 'package:pokeapp/core/shared/presentation/widgets/connectivity_listener.dart';
import 'package:pokeapp/features/pokemon_list/presentation/widgets/pokemon_component.dart';
import '../cubit/pokemon_list_cubit.dart';

class PokemonListScreen extends StatelessWidget {
  const PokemonListScreen({super.key});

  PokemonListCubit get pokemonListCubit => getIt<PokemonListCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => pokemonListCubit..loadPokemonList(),
      child: ConnectivityListener(
        onConnectivityChanged: (isConnected) {
          if (isConnected) {
            context.read<PokemonListCubit>().loadPokemonList();
          }
        },
        child: PokemonComponent(),
      ),
    );
  }
}
