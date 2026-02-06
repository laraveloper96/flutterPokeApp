import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokeapp/core/error/failures.dart';
import 'package:pokeapp/features/pokemon_list/domain/entities/pokemon.dart';
import 'package:pokeapp/features/pokemon_list/domain/usecases/get_pokemon_list.dart';
import 'package:pokeapp/features/pokemon_list/presentation/cubit/pokemon_list_cubit.dart';

class MockGetPokemonList extends Mock implements GetPokemonList {}

class FakeGetPokemonListParams extends Fake implements GetPokemonListParams {}

void main() {
  late PokemonListCubit cubit;
  late MockGetPokemonList mockGetPokemonList;

  setUpAll(() {
    registerFallbackValue(FakeGetPokemonListParams());
  });

  setUp(() {
    mockGetPokemonList = MockGetPokemonList();
    cubit = PokemonListCubit(getPokemonList: mockGetPokemonList);
  });

  tearDown(() {
    cubit.close();
  });

  group('PokemonListCubit', () {
    const tPokemon = Pokemon(id: 1, name: 'bulbasaur', imageUrl: 'url');
    final tPokemonList = [tPokemon];

    test('initial state should be PokemonListInitial', () {
      expect(cubit.state, isA<PokemonListInitial>());
    });

    blocTest<PokemonListCubit, PokemonListState>(
      'emits [PokemonListLoading, PokemonListLoaded] when successful',
      build: () {
        when(
          () => mockGetPokemonList(any()),
        ).thenAnswer((_) async => (null, tPokemonList));
        return cubit;
      },
      act: (cubit) => cubit.loadPokemonList(),
      expect: () => [
        isA<PokemonListLoading>().having(
          (s) => s.isFirstFetch,
          'isFirstFetch',
          true,
        ),
        isA<PokemonListLoaded>()
            .having((s) => s.pokemonList, 'pokemonList', tPokemonList)
            .having((s) => s.hasReachedMax, 'hasReachedMax', true),
      ],
      verify: (_) {
        verify(() => mockGetPokemonList(any())).called(1);
      },
    );

    blocTest<PokemonListCubit, PokemonListState>(
      'emits [PokemonListLoading, PokemonListError] when failure',
      build: () {
        when(() => mockGetPokemonList(any())).thenAnswer(
          (_) async => (Failure.serverFailure(message: 'Error'), null),
        );
        return cubit;
      },
      act: (cubit) => cubit.loadPokemonList(),
      expect: () => [
        isA<PokemonListLoading>(),
        isA<PokemonListError>().having((s) => s.message, 'message', 'Error'),
      ],
    );
  });
}
