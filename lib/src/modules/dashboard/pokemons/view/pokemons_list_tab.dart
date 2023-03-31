import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/src/modules/dashboard/pokemons/bloc/events/pokemons_list_events.dart';
import 'package:pokedex/src/modules/dashboard/pokemons/bloc/pokemons_list_bloc.dart';
import 'package:pokedex/src/modules/dashboard/pokemons/bloc/states/pokemons_list_state.dart';
import 'package:pokedex/src/shared/widgets/pokemon_card_widget.dart';

class PokemonListTab extends StatefulWidget {
  const PokemonListTab({super.key});

  @override
  State<PokemonListTab> createState() => _PokemonListTabState();
}

class _PokemonListTabState extends State<PokemonListTab> {
  @override
  void initState() {
    super.initState();
    final bloc = Modular.get<PokemonsListBloc>();
    bloc.add(GetPokemonListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PokemonsListBloc, PokemonsListStates>(
          bloc: Modular.get<PokemonsListBloc>(),
          builder: (context, state) {
            if (state is PokemonsListInitialState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PokemonsListSuccessState) {
              /*
              return PagedGridView<int, PokemonModel>(
                gridDelegate: SliverGridDelegate(),
                pagingController: controller.pagingController,
                padding: EdgeInsets.symmetric(horizontal: 25),
                builderDelegate:
                PagedChildBuilderDelegate<NotificationModel>(
                    itemBuilder: (context, item, index) {
                      return NotificationCard(
                        notification: item,
                        setState: () {
                          setState(() {});
                        },
                      );
                    }, firstPageErrorIndicatorBuilder: (context) {
                  return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.warning,
                              size: 30, color: Colors.grey),
                          Text(
                            "Sem notificações",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ));
                }),
              );

               */
              return GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: state.pokemons.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return PokemonCardWidget(
                      pokemon: state.pokemons[index],
                    );
                  });
            }
            return Container();
          }),
    );
  }
}
