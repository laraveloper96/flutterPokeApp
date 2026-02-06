import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/core/shared/presentation/widgets/app_error_view.dart';
import 'package:pokeapp/features/pokemon_detail/domain/entities/pokemon_detail.dart';
import 'package:pokeapp/features/pokemon_detail/presentation/cubit/pokemon_detail_cubit.dart';
import 'package:pokeapp/features/pokemon_detail/presentation/widgets/appbar_widget.dart';
import 'package:pokeapp/features/pokemon_detail/presentation/widgets/poke_title_widget.dart';
import 'package:pokeapp/features/pokemon_detail/presentation/widgets/tabs/poke_about_tab.dart';
import 'package:pokeapp/features/pokemon_detail/presentation/widgets/tabs/poke_evolution_tab.dart';
import 'package:pokeapp/features/pokemon_detail/presentation/widgets/tabs/poke_stats_tab.dart';
import 'package:shimmer/shimmer.dart';

part 'loading_view.dart';
part 'detail_view.dart';

const double pokeballSize = 180;
const double pokeballOpacity = 0.1;
const double pokemonImageSize = 250;

class DetailComponent extends StatelessWidget {
  const DetailComponent({super.key, required this.pokemonId});

  final int pokemonId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
      builder: (context, state) {
        if (state is PokemonDetailLoading) {
          return const LoadingView();
        }
        if (state is PokemonDetailLoaded) {
          final pokemon = state.pokemon;
          return DetailView(pokemon: pokemon);
        }
        if (state is PokemonDetailError) {
          return AppErrorView(
            error: state.message,
            onRetry: () {
              context.read<PokemonDetailCubit>().loadPokemonDetail(pokemonId);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
