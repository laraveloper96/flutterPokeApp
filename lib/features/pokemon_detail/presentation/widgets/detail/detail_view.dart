part of 'detail_component.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key, required this.pokemon});

  final PokemonDetail pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pokemon.typeColor,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              PokeAppBarWidget(pokemon: pokemon),
              PokeTitleWidget(pokemon: pokemon),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.purple,
                    tabs: const [
                      Tab(text: 'About'),
                      Tab(text: 'Base Stats'),
                      Tab(text: 'Evolution'),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: Container(
            color: Colors.white,
            child: TabBarView(
              children: [
                PokeAboutTab(pokemon: pokemon),
                PokeStatsTab(pokemon: pokemon),
                PokeEvolutionTab(pokemon: pokemon),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
