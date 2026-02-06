import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokeapp/core/shared/presentation/widgets/app_error_view.dart';
import 'package:pokeapp/features/pokemon_list/domain/entities/pokemon.dart';
import 'package:pokeapp/features/pokemon_list/presentation/cubit/pokemon_list_cubit.dart';
import 'package:pokeapp/features/pokemon_list/presentation/widgets/pokemon_component.dart';

class MockPokemonListCubit extends MockCubit<PokemonListState>
    implements PokemonListCubit {}

class FakePokemonListState extends Fake implements PokemonListState {}

class MockHttpOverride extends Mock implements HttpOverrides {}

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}

class MockHttpHeaders extends Mock implements HttpHeaders {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockPokemonListCubit mockCubit;

  setUpAll(() {
    HttpOverrides.global = MockHttpOverride();
  });

  setUp(() {
    mockCubit = MockPokemonListCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<PokemonListCubit>.value(
        value: mockCubit,
        child: const PokemonComponent(),
      ),
    );
  }

  group('PokemonComponent Widget Test', () {
    testWidgets('renders CircularProgressIndicator when loading first fetch', (
      tester,
    ) async {
      when(
        () => mockCubit.state,
      ).thenReturn(const PokemonListLoading([], isFirstFetch: true));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders list of pokemon when loaded', (tester) async {
      final tPokemonList = [
        const Pokemon(
          id: 1,
          name: 'bulbasaur',
          imageUrl: 'http://example.com/1.png',
        ),
        const Pokemon(
          id: 2,
          name: 'ivysaur',
          imageUrl: 'http://example.com/2.png',
        ),
      ];
      when(() => mockCubit.state).thenReturn(
        PokemonListLoaded(pokemonList: tPokemonList, hasReachedMax: false),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text(tPokemonList.first.name.toUpperCase()), findsOneWidget);
      expect(find.text(tPokemonList.last.name.toUpperCase()), findsOneWidget);
    });

    testWidgets('renders AppErrorView when error occurs', (tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(const PokemonListError(message: 'Error message'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(AppErrorView), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.textContaining('Error message'), findsOneWidget);
    });
  });
}
