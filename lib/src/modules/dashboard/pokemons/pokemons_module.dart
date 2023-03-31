import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/modules/dashboard/pokemons/bloc/pokemons_list_bloc.dart';
import 'package:pokedex/src/shared/pokemon_core/repository/pokemon_repository.dart';

import 'pokemons_controller.dart';
import 'view/pokemons_list_tab.dart';

class PokemonsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => PokemonsController(repository: i.get<PokemonRepository>()),export: true),
        Bind((i) => PokemonsListBloc(controller: i.get<PokemonsController>()),export: true),
      ];

  @override
  List<ModularRoute> get routes => [];
}
