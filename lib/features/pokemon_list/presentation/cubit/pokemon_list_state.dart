part of 'pokemon_list_cubit.dart';

abstract class PokemonListState extends Equatable {
  const PokemonListState();

  @override
  List<Object> get props => [];
}

class PokemonListInitial extends PokemonListState {}

class PokemonListLoading extends PokemonListState {
  final List<Pokemon> oldPokemonList;
  final bool isFirstFetch;

  const PokemonListLoading(this.oldPokemonList, {this.isFirstFetch = false});
  
  @override
  List<Object> get props => [oldPokemonList, isFirstFetch];
}

class PokemonListLoaded extends PokemonListState {
  final List<Pokemon> pokemonList;
  final bool hasReachedMax;

  const PokemonListLoaded({
    required this.pokemonList,
    required this.hasReachedMax,
  });

  @override
  List<Object> get props => [pokemonList, hasReachedMax];
}

class PokemonListError extends PokemonListState {
  final String message;

  const PokemonListError({required this.message});

  @override
  List<Object> get props => [message];
}
