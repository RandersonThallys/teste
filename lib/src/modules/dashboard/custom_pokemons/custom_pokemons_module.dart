import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/modules/dashboard/custom_pokemons/bloc/custom_pokemons_bloc.dart';
import 'package:pokedex/src/modules/dashboard/custom_pokemons/custom_pokemons_controller.dart';
import 'package:pokedex/src/shared/pokemon_core/repository/pokemon_repository.dart';

import 'view/custom_pokemons_tab.dart';

class CustomPokemonsModule extends Module {
 @override
  List<Module> get imports => [
    
  ];
  @override
  List<Bind> get binds => [
   Bind((i) => CustomPokemonsController(repository: i.get<PokemonRepository>()),export: true),
   Bind((i) => CustomPokemonsBloc(controller: i.get<CustomPokemonsController>()),export: true),
  ];

  @override
  List<ModularRoute> get routes => [
 ChildRoute('/',
        child: ((context, args) =>  CustomPokemonsTab()),
        transition: TransitionType.fadeIn,
        duration: const Duration(milliseconds: 600)),
   
    
  ];
}