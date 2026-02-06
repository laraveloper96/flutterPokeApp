import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/pokemon_detail.dart';
import '../../domain/usecases/get_pokemon_detail.dart';

part 'pokemon_detail_state.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final GetPokemonDetail getPokemonDetail;

  PokemonDetailCubit({required this.getPokemonDetail})
    : super(PokemonDetailInitial());

  Future<void> loadPokemonDetail(int id) async {
    emit(PokemonDetailLoading());
    final (failure, pokemon) = await getPokemonDetail(
      GetPokemonDetailParams(id: id),
    );
    if (failure != null) {
      emit(PokemonDetailError(message: failure.message));
      return;
    }
    emit(PokemonDetailLoaded(pokemon: pokemon!));
  }
}
