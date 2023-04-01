import 'dart:ui';

class PokeApi {
  static String requestPokemon({required String pokemon}) {
    return 'https://pokeapi.co/api/v2/pokemon/$pokemon';
  }

  static const requestPokemonsList = 'https://pokeapi.co/api/v2/pokemon';
  static int colorSelect({required String pokemonType}) {
    switch (pokemonType) {
      case 'grass':
        return 0xff7AC74C;
      case 'fire':
        return 0xfffEE8130;
      case 'water':
        return 0xff6390F0;
      case 'electric':
        return 0xffF7D02C;
      case 'ice':
        return 0xff96D9D6;
      case 'fighting':
        return 0xffC22E28;
      case 'poison':
        return 0xffA33EA1;
      case 'ground':
        return 0xffE2BF65;
      case 'flying':
        return 0xffA98FF3;
      case 'psychic':
        return 0xffF95587;
      case 'bug':
        return 0xffA6B91A;
      case 'rock':
        return 0xffB6A136;
      case 'ghost':
        return 0xff735797;
      case 'dragon':
        return 0xff6F35FC;
      case 'dark':
        return 0xff705746;
      case 'steel':
        return 0xffB7B7CE;
      case 'fairy':
        return 0xffD685AD;

      default:
        return 0xffA8A77A;
    }
  }
}
