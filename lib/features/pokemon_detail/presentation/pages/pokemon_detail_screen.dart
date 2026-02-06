import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/core/di/service_locator.dart';
import 'package:pokeapp/core/shared/presentation/widgets/connectivity_listener.dart';
import 'package:pokeapp/features/pokemon_detail/presentation/widgets/detail/detail_component.dart';
import '../cubit/pokemon_detail_cubit.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({super.key, required this.pokemonId});
  final int pokemonId;

  PokemonDetailCubit get pokemonDetailCubit => getIt<PokemonDetailCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => pokemonDetailCubit..loadPokemonDetail(pokemonId),
      child: ConnectivityListener(
        onConnectivityChanged: (isConnected) {
          if (isConnected) {
            context.read<PokemonDetailCubit>().loadPokemonDetail(pokemonId);
          }
        },
        child: DetailComponent(pokemonId: pokemonId),
      ),
    );
  }
}
