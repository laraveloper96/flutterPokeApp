import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_pokemon_list.dart';

part 'pokemon_list_state.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  final GetPokemonList getPokemonList;

  static const int _limit = 20;

  PokemonListCubit({required this.getPokemonList})
    : super(PokemonListInitial());

  Future<void> loadPokemonList() async {
    if (state is PokemonListLoading) return;

    final currentState = state;
    var oldPosts = <Pokemon>[];
    if (currentState is PokemonListLoaded) {
      oldPosts = currentState.pokemonList;
    }

    if (currentState is PokemonListInitial) {
      emit(PokemonListLoading(oldPosts, isFirstFetch: true));
    } else {
      emit(PokemonListLoading(oldPosts, isFirstFetch: false));
    }

    final (failure, result) = await getPokemonList(
      GetPokemonListParams(offset: oldPosts.length, limit: _limit),
    );

    if (failure != null) {
      emit(PokemonListError(message: failure.message));
      return;
    }

    if (result != null) {
      emit(
        PokemonListLoaded(
          pokemonList: oldPosts + result,
          hasReachedMax: result.length < _limit,
        ),
      );
      return;
    }

    emit(PokemonListError(message: failure!.message));
    return;
  }
}
