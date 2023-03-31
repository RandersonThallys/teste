import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/modules/dashboard/custom_pokemons/bloc/custom_pokemons_bloc.dart';
import 'package:pokedex/src/modules/dashboard/custom_pokemons/custom_pokemons_controller.dart';
import 'package:pokedex/src/modules/dashboard/pokemons/pokemons_controller.dart';
import 'package:pokedex/src/shared/pokemon_core/pokemon_core_module.dart';
import 'package:pokedex/src/shared/pokemon_core/repository/pokemon_repository.dart';

import 'bloc/home_bloc.dart';
import 'custom_pokemons/custom_pokemons_module.dart';
import 'pokemons/bloc/pokemons_list_bloc.dart';
import 'pokemons/pokemons_module.dart';
import 'pokemons/view/pokemon_descripiton_page.dart';
import 'view/home_page.dart';

class DashboardModule extends Module {
  @override
  List<Module> get imports => [PokemonsModule(), CustomPokemonsModule(), PokemonCoreModule()];
  @override
  List<Bind> get binds => [
    Bind.singleton<HomeBloc>((i) => HomeBloc(),export: true),

    Bind.factory<PokemonsController>((i) => PokemonsController(repository: i.get<PokemonRepository>()),export: true),
    Bind.singleton<PokemonsListBloc>((i) => PokemonsListBloc(controller: i.get<PokemonsController>()),export: true),

    Bind.factory<CustomPokemonsController>((i) => CustomPokemonsController(repository: i.get<PokemonRepository>()),export: true),
    Bind.singleton<CustomPokemonsBloc>((i) => CustomPokemonsBloc(controller: i.get<CustomPokemonsController>()),export: true),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: ((context, args) => HomePage()),
        transition: TransitionType.fadeIn,
        duration: const Duration(milliseconds: 600)),
         ChildRoute('/pokemon-description',
        child: ((context, args) => PokemonDescriptionPage(pokemon: args.data,)),
        transition: TransitionType.fadeIn,
        duration: const Duration(milliseconds: 600)),
    ModuleRoute('/pokemons', module: PokemonsModule()),
    ModuleRoute('/custom-pokemons', module: CustomPokemonsModule()),
  ];
}
