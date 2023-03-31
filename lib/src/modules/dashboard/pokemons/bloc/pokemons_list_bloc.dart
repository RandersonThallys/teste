import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/src/modules/dashboard/pokemons/pokemons_controller.dart';
import 'package:pokedex/src/shared/pokemon_core/model/pokemon_model.dart';

import 'events/pokemons_list_events.dart';
import 'states/pokemons_list_state.dart';

class PokemonsListBloc extends Bloc<PokemonsListEvent, PokemonsListStates> {
  PokemonsController controller;

  PokemonsListBloc({required this.controller}) : super(PokemonsListInitialState()) {
    on<GetPokemonListEvent>(_getPokemonsList);
    on<NextPageEvent>(_nextPage);
  }

  Future _getPokemonsList(
      GetPokemonListEvent event, Emitter<PokemonsListStates> emit) async {
    late List<PokemonModel> pokemons;

    pokemons = await controller.getPokemonsList();

    emit(PokemonsListStates.success(pokemons: pokemons));
  }

  Future _nextPage(NextPageEvent event, Emitter<PokemonsListStates> emit) async {

  }
}
