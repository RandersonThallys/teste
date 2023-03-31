import 'dart:ui';

class PokeApi {
  static String requestPokemon({required String pokemon}) {
    return 'https://pokeapi.co/api/v2/pokemon/$pokemon';
  }

  static const requestPokemonsList = 'https://pokeapi.co/api/v2/pokemon';
  static int colorSelect({required String pokemonType}) {
    switch (pokemonType) {
      case 'grass':
        return 0xff46d0b0;
      case 'fire':
        return 0xfffb6c6c;
      case 'water':
        return 0xff77bdfe;
      case 'thunder':
        return  0xffffd86f;
      default:
        return 0xff9e9e9e;
    }
  }
}