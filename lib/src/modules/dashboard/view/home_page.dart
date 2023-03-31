import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/app_routes.dart';
import 'package:pokedex/src/modules/dashboard/bloc/events/home_events.dart';
import 'package:pokedex/src/modules/dashboard/bloc/home_bloc.dart';
import 'package:pokedex/src/modules/dashboard/bloc/states/home_state.dart';
import 'package:pokedex/src/modules/dashboard/custom_pokemons/view/custom_pokemons_tab.dart';

import '../pokemons/view/pokemons_list_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  pokemonsListTab() async {
    return await Modular.to.pushNamed<Widget>(AppRoutes.pokemonList());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocBuilder<HomeBloc, HomeStates>(
        bloc: Modular.get<HomeBloc>(),
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: (){
                      final bloc = Modular.get<HomeBloc>();
                      bloc.add(TurnThemeEvent());
                    },
                    icon: Icon(state is LightState ? Icons.dark_mode : Icons.light_mode)
                )
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(text: "POKÉMONS"),
                  Tab(text: "CUSTOM POKÉMONS"),
                ],
              ),
              title: const Text('PokeDex'),
            ),
            body: const TabBarView(
              children: [
                PokemonListTab(),
                CustomPokemonsTab(),
              ],
            ),
          );
        },
      )
    );
  }
}
