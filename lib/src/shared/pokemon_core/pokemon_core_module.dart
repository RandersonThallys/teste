import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/shared/services/http/http_service_impl.dart';

import 'repository/pokemon_repository.dart';




class PokemonCoreModule extends Module{
 
   @override
  final List<Bind> binds = [
    Bind.singleton<PokemonRepository>(((i) => PokemonRepository(httpService: i.get<HttpServiceImp>())), export: true)
  ];
}