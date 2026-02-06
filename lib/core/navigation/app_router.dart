import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokeapp/features/pokemon_detail/presentation/pages/pokemon_detail_screen.dart';
import 'package:pokeapp/features/pokemon_list/presentation/pages/pokemon_list_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const PokemonListScreen()),
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return PokemonDetailScreen(pokemonId: id);
      },
    ),
  ],
  errorBuilder: (context, state) {
    return const Scaffold(body: Center(child: Text('Error')));
  },
);
