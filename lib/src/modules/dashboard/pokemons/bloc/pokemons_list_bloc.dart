import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/src/modules/dashboard/pokemons/pokemons_controller.dart';
import 'package:pokedex/src/shared/pokemon_core/model/pokemon_model.dart';

import 'events/pokemons_list_events.dart';
import 'states/pokemons_list_state.dart';

class PokemonsListBloc extends Bloc<PokemonsListEvent, PokemonsListStates> {
  PokemonsController controller;

  PokemonsListBloc({required this.controller})
      : super(PokemonsListInitialState()) {
    on<GetPokemonListEvent>(_getPokemonsList);
    on<NextPageEvent>(_nextPage);
  }

  Future _getPokemonsList(
      GetPokemonListEvent event, Emitter<PokemonsListStates> emit) async {
    emit(state.loading());
    late List<PokemonModel> pokemons;

    pokemons = await controller.getPokemonsList();

    emit(state.success(pokemons: pokemons));
    controller.pagingController
        .appendPage(state.pokemons, controller.offset);
  }

  Future _nextPage(
      NextPageEvent event, Emitter<PokemonsListStates> emit) async {
    late List<PokemonModel> pokemons;
    pokemons = await controller.getPokemonsList();
    state.pokemons.addAll(pokemons);
    emit(state.success(pokemons: pokemons));
    
    if(controller.lastPage){
      controller.pagingController.appendLastPage(state.pokemons);
    }else{
      controller.pagingController
        .appendPage(state.pokemons, controller.offset);
    }
  }
}
