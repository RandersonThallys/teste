import 'package:pokedex/src/shared/pokemon_core/model/pokemon_model.dart';

abstract class PokemonsListStates {
  final List<PokemonModel> pokemons;

  PokemonsListStates({required this.pokemons});

  PokemonsListSuccessState success(
          {required List<PokemonModel> pokemons}) =>
      PokemonsListSuccessState(pokemons: pokemons);

  PokemonsListLoadingState loading(){
      return PokemonsListLoadingState(pokemons: pokemons);

  }
}

class PokemonsListInitialState extends PokemonsListStates {
  PokemonsListInitialState() : super(pokemons: []);
}

class PokemonsListLoadingState extends PokemonsListStates {
  PokemonsListLoadingState({required super.pokemons});
}

class PokemonsListSuccessState extends PokemonsListStates {
  PokemonsListSuccessState({required super.pokemons});
}
