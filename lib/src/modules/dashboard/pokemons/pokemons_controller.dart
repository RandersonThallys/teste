import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/src/shared/pokemon_core/model/pokemon_model.dart';
import 'package:pokedex/src/shared/pokemon_core/repository/pokemon_repository.dart';

class PokemonsController {
  final PokemonRepository repository;

  PokemonsController({required this.repository});

  PagingController<int, PokemonModel> pagingController = PagingController(firstPageKey: 1);
  int offset = 0;
  bool lastPage = false;

  Future<List<PokemonModel>> getPokemonsList() async {
    try {
      var result = await repository.getAllPokemons(offset,lastPage);

      offset += 100;
      if(result.length < 100) lastPage = true;
      print(lastPage);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
