// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/src/shared/pokemon_core/model/pokemon_model.dart';
import 'package:pokedex/src/shared/services/http/http_service.dart';

import '../adapters/pokemon_adapter.dart';

class PokemonRepository {
  final HttpService httpService;
  PokemonRepository({
    required this.httpService,
  });
  static const platform = MethodChannel('flutter.pokedex');

  Future<List<PokemonModel>> getAllPokemons(int offset, bool isLastPage) async{
    String url = 'https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=100';
    List<PokemonModel> pokemons = [];

     var response = await httpService.get(url);
    var jsonPokemonsName = jsonDecode(response.body);
    List<Map> listPokemonsMap = [];
    for (Map i in jsonPokemonsName['results']) {
      var responsePokemon = await httpService.get(i['url']);
      var jsonPokemon = jsonDecode(responsePokemon.body);
      listPokemonsMap.add(jsonPokemon);
      pokemons = listPokemonsMap.map((e) => PokemonAdapter.fromMap(e as Map<String,dynamic>)).toList();
    }
    

    

    return pokemons;
  }

  Future<List<PokemonModel>> getAllCustomPokemons() async {
    try {
      final List<dynamic> result = await platform.invokeMethod("getPokemons");

      print('RESULT -> $result');

      List<PokemonModel> pokemons = [];

      for (var element in result) {
        pokemons.add(PokemonModel(
          id: element['id'],
          name: element['name'],
          sprite: element['sprite'],
          stats: json.decode(element['stats']),
          types: (json.decode(element['types']) as List).map((item) => item as String).toList(),
          description: element['description'],
          weight: element['weight'],
          height: element['height'],
        ));
      }

      return pokemons;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return List<PokemonModel>.empty();
    }
  }

  Future<bool> addCustomPokemon(PokemonModel pokemon) async {
    try {
      final bool result = await platform.invokeMethod("addPokemon", pokemon.toJson());

      if (kDebugMode) {
        print('RESULT -> $result');
      }
      return result;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return false;
  }

  Future<bool> editCustomPokemon(PokemonModel pokemon) async {
    try {
      final bool result = await platform.invokeMethod("editPokemon", pokemon.toJson());

      if (kDebugMode) {
        print('RESULT -> $result');
      }
      return result;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return false;
  }

  Future<bool> removeCustomPokemon(PokemonModel pokemon) async {
    try {
      var arguments = <String, int>{
        "id": pokemon.id!,
      };

      final bool result = await platform.invokeMethod("removePokemon", arguments);

      if (kDebugMode) {
        print('RESULT -> $result');
      }
      return result;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return false;
  }
}
