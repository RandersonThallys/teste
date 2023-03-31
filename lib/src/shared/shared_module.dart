import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/shared/services/http/http_service.dart';

import 'pokemon_core/pokemon_core_module.dart';
import 'services/http/http_service_impl.dart';

class SharedModule extends Module {
   @override
  List<Module> get imports => [
    PokemonCoreModule(),
  ];
  
  @override
  final List<Bind> binds = [
    Bind.singleton<HttpService>(((i) => HttpServiceImp()), export: true)
  ];

  
}
