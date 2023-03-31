import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/app_routes.dart';
import 'package:pokedex/src/modules/dashboard/custom_pokemons/bloc/custom_pokemons_bloc.dart';
import 'package:pokedex/src/modules/dashboard/custom_pokemons/bloc/events/custom_pokemons_events.dart';
import 'package:pokedex/src/modules/dashboard/widgets/add_pokemon_dialog.dart';
import 'package:pokedex/src/shared/helpers/poke_api.dart';
import 'package:pokedex/src/shared/pokemon_core/model/pokemon_model.dart';

class PokemonCardWidget extends StatelessWidget {
  const PokemonCardWidget({Key? key, required this.pokemon, this.canEdit = false}) : super(key: key);
  final PokemonModel pokemon;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed(AppRoutes.pokemonDescription(),arguments: pokemon),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Color(PokeApi.colorSelect(pokemonType: pokemon.types.first)),
        ),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pokemon.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                  for (String i in pokemon.types)
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(50)),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: Text(i,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          )),
                    )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 3,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '#${pokemon.id}',
                          style:
                          TextStyle(color: Colors.black.withOpacity(0.3)),
                        ),
                        const SizedBox(width: 5),
                        if (canEdit)
                          PopupMenuButton(
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: ListTile(
                                  onTap: () {
                                    Modular.to.pop();
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            AddPokemonDialog(pokemon: pokemon));
                                  },
                                  leading: Icon(Icons.edit),
                                  title: const Text("Editar"),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                ),
                              ),
                              PopupMenuItem(
                                child: ListTile(
                                  onTap: () {
                                    final bloc = Modular.get<CustomPokemonsBloc>();
                                    bloc.add(RemovePokemonEvent(pokemon: pokemon));
                                    Modular.to.pop();
                                  },
                                  leading: const Icon(Icons.delete_forever,
                                      color: Colors.red),
                                  title: const Text("Excluir"),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 5,
                      child: pokemon.sprite.contains('http')
                          ? Image.network(pokemon.sprite)
                          : Container()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}