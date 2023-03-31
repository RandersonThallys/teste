import 'package:pokedex/src/shared/pokemon_core/model/pokemon_model.dart';
import 'package:pokedex/src/shared/pokemon_core/repository/pokemon_repository.dart';

class CustomPokemonsController {
  final PokemonRepository repository;
  CustomPokemonsController({required this.repository});

  Future<List<PokemonModel>> getPokemons() async {
    try {
      var result = await repository.getAllCustomPokemons();

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addPokemon(PokemonModel pokemon) async {
    try {
      var result = await repository.addCustomPokemon(pokemon);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removePokemon(PokemonModel pokemon) async {
    try {
      var result = await repository.removeCustomPokemon(pokemon);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> editPokemon(PokemonModel pokemon) async {
    try {
      var result = await repository.editCustomPokemon(pokemon);

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
