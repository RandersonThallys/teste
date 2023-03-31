import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/modules/dashboard/dashboard_module.dart';
import 'package:pokedex/src/modules/splash/splash_module.dart';
import 'package:pokedex/src/shared/pokemon_core/pokemon_core_module.dart';
import 'package:pokedex/src/shared/shared_module.dart';

class AppModule extends Module {
 @override
  List<Module> get imports => [
    PokemonCoreModule(),
    SharedModule(),
    DashboardModule(),
    SplashModule(),
  ];
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/dashboard', module:DashboardModule()),
    
  ];
}