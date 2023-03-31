import 'package:pokedex/src/shared/pokemon_core/model/pokemon_model.dart';

abstract class CustomPokemonsEvent{
}

class GetPokemonsEvent extends CustomPokemonsEvent{}

class AddPokemonEvent extends CustomPokemonsEvent{
  final PokemonModel pokemon;

  AddPokemonEvent({required this.pokemon});
}

class RemovePokemonEvent extends CustomPokemonsEvent{
  final PokemonModel pokemon;

  RemovePokemonEvent({required this.pokemon});
}

class EditPokemonEvent extends CustomPokemonsEvent{
  final PokemonModel pokemon;

  EditPokemonEvent({required this.pokemon});
}