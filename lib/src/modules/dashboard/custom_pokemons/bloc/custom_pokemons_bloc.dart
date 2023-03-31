import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/src/modules/dashboard/custom_pokemons/custom_pokemons_controller.dart';
import 'package:pokedex/src/shared/pokemon_core/model/pokemon_model.dart';

import 'events/custom_pokemons_events.dart';
import 'states/custom_pokemons_state.dart';

class CustomPokemonsBloc extends Bloc<CustomPokemonsEvent, CustomPokemonsStates> {
  CustomPokemonsController controller;

  CustomPokemonsBloc({required this.controller}) : super(CustomPokemonsInitialState()) {
    on<GetPokemonsEvent>(_getPokemonsList);
    on<AddPokemonEvent>(_addPokemon);
    on<RemovePokemonEvent>(_removePokemon);
    on<EditPokemonEvent>(_editPokemon);
  }

  Future _getPokemonsList(
      GetPokemonsEvent event, Emitter<CustomPokemonsStates> emit) async {
    late List<PokemonModel> pokemons;

    pokemons = await controller.getPokemons();

    emit(CustomPokemonsStates.success(pokemons: pokemons));
  }

  Future _addPokemon(AddPokemonEvent event, Emitter<CustomPokemonsStates> emit) async {
    emit(CustomPokemonsStates.loading());

    try {
      await controller.addPokemon(event.pokemon);
    } catch (e){
      if (kDebugMode) {
        print(e);
      }
    }

    late List<PokemonModel> pokemons;

    pokemons = await controller.getPokemons();

    emit(CustomPokemonsStates.success(pokemons: pokemons));
  }

  Future _removePokemon(RemovePokemonEvent event, Emitter<CustomPokemonsStates> emit) async {
    emit(CustomPokemonsStates.loading());

    try {
      await controller.removePokemon(event.pokemon);
    } catch (e){
      if (kDebugMode) {
        print(e);
      }
    }

    late List<PokemonModel> pokemons;

    pokemons = await controller.getPokemons();

    emit(CustomPokemonsStates.success(pokemons: pokemons));
  }

  Future _editPokemon(EditPokemonEvent event, Emitter<CustomPokemonsStates> emit) async {
    emit(CustomPokemonsStates.loading());

    try {
      await controller.editPokemon(event.pokemon);
    } catch (e){
      if (kDebugMode) {
        print(e);
      }
    }

    late List<PokemonModel> pokemons;

    pokemons = await controller.getPokemons();

    emit(CustomPokemonsStates.success(pokemons: pokemons));
  }
}
