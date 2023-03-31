import 'package:flutter/material.dart';
import 'package:pokedex/src/modules/dashboard/widgets/pokemon_field.dart';
import 'package:pokedex/src/shared/helpers/poke_api.dart';
import 'package:pokedex/src/shared/pokemon_core/model/pokemon_model.dart';

class PokemonDescriptionPage extends StatefulWidget {
  final PokemonModel pokemon;

  const PokemonDescriptionPage({Key? key, required this.pokemon})
      : super(key: key);

  @override
  State<PokemonDescriptionPage> createState() => _PokemonDescriptionPageState();
}

class _PokemonDescriptionPageState extends State<PokemonDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(
              PokeApi.colorSelect(pokemonType: widget.pokemon.types.first)),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border))
          ],
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Color(
                  PokeApi.colorSelect(pokemonType: widget.pokemon.types.first)),
              child: Text(widget.pokemon.name,
                  style: const TextStyle(fontSize: 30, color: Colors.white)),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: const EdgeInsets.only(top: 80, left: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                          MediaQuery.of(context).size.width * 0.12),
                    ),
                    color: Colors.white,
                  ),
                  child: ListView(
                    children: [
                      PokemonField(
                          title: 'Description: ',
                          description: widget.pokemon.description),
                      PokemonField(
                          title: 'Height: ',
                          description: widget.pokemon.height.toString()),
                      PokemonField(
                          title: 'Weight: ',
                          description: widget.pokemon.weight.toString()),
                      ...widget.pokemon.stats.keys.map(
                        (e) => PokemonField(
                            title: '$e: ',
                            description: widget.pokemon.stats[e].toString()),
                      )
                    ],
                  )),
            ),
            Positioned(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              child: widget.pokemon.sprite.contains('http')
                  ? Image.network(
                      widget.pokemon.sprite,
                      scale: 0.4,
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
