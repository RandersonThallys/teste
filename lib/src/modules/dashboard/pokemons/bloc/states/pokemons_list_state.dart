import 'package:pokedex/src/shared/pokemon_core/model/pokemon_model.dart';

abstract class PokemonsListStates {
  static PokemonsListSuccessState success({required List<PokemonModel> pokemons}) =>
      PokemonsListSuccessState(pokemons: pokemons);
}

class PokemonsListInitialState extends PokemonsListStates {
  List<PokemonModel> pokemons = [];

  
}



class PokemonsListSuccessState extends PokemonsListStates {
  final List<PokemonModel> pokemons;
  PokemonsListSuccessState({required this.pokemons});
}
