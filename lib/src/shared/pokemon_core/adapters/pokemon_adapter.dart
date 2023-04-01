import 'package:pokedex/src/shared/pokemon_core/model/pokemon_model.dart';

class PokemonAdapter{
    static PokemonModel fromMap(Map map) {
    int id = map['id'];
    String name = map['name'];
    String sprite = map['sprites']['front_default'] ?? '';
    
    Map<String, int> stats = {};
    for (Map i in map['stats']) {
      stats[i['stat']['name']] = i['base_stat'];
    }
    List<String> types = [for (Map i in map['types']) i['type']['name']];
    int weight = map['weight'];
    int height = map['height'];

    return PokemonModel(
      id: id,
      name: name,
      description: '',
      sprite: sprite,
      stats: stats,
      types: types,
      weight: weight,
      height: height,
    );
  }
}