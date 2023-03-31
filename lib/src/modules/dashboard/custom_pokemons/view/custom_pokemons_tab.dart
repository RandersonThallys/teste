import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/modules/dashboard/custom_pokemons/bloc/custom_pokemons_bloc.dart';
import 'package:pokedex/src/modules/dashboard/custom_pokemons/bloc/events/custom_pokemons_events.dart';
import 'package:pokedex/src/modules/dashboard/custom_pokemons/bloc/states/custom_pokemons_state.dart';
import 'package:pokedex/src/modules/dashboard/widgets/add_pokemon_dialog.dart';
import 'package:pokedex/src/shared/widgets/pokemon_card_widget.dart';

class CustomPokemonsTab extends StatefulWidget {
  const CustomPokemonsTab({super.key});

  @override
  State<CustomPokemonsTab> createState() => _CustomPokemonsTabState();
}

class _CustomPokemonsTabState extends State<CustomPokemonsTab> {
  @override
  void initState() {
    final bloc = Modular.get<CustomPokemonsBloc>();
    bloc.add(GetPokemonsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CustomPokemonsBloc, CustomPokemonsStates>(
          bloc: Modular.get< CustomPokemonsBloc>(),
          builder: (context, state) {
            if (state is  CustomPokemonsInitialState || state is  CustomPokemonsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is  CustomPokemonsSuccessState) {
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
                      canEdit: true,
                    );
                  });
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPressed: () {
          showDialog(
              context: context, builder: (context) => AddPokemonDialog());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
