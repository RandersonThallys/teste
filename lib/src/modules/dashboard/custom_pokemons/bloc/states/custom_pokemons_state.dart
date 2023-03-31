import 'package:pokedex/src/shared/pokemon_core/model/pokemon_model.dart';

abstract class CustomPokemonsStates {
  static CustomPokemonsSuccessState success({required List<PokemonModel> pokemons}) =>
      CustomPokemonsSuccessState(pokemons: pokemons);
  static CustomPokemonsLoadingState loading() => CustomPokemonsLoadingState();
}

class CustomPokemonsInitialState extends CustomPokemonsStates {
  List<PokemonModel> pokemons = [];

  
}

class CustomPokemonsSuccessState extends CustomPokemonsStates {
  final List<PokemonModel> pokemons;
  CustomPokemonsSuccessState({required this.pokemons});
}

class CustomPokemonsLoadingState extends CustomPokemonsStates {

}
