import 'package:pokedex/src/shared/pokemon_core/model/pokemon_model.dart';

abstract class HomeStates {
  static LightState light() => LightState();
  static DarkState dark() => DarkState();
}

class LightState extends HomeStates {}
class DarkState extends HomeStates {}
