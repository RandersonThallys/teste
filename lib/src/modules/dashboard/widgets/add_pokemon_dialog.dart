import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/modules/dashboard/custom_pokemons/bloc/custom_pokemons_bloc.dart';
import 'package:pokedex/src/modules/dashboard/custom_pokemons/bloc/events/custom_pokemons_events.dart';
import 'package:pokedex/src/modules/dashboard/widgets/custom_field.dart';
import 'package:pokedex/src/shared/pokemon_core/model/pokemon_model.dart';

class AddPokemonDialog extends StatefulWidget {
  PokemonModel? pokemon;

  AddPokemonDialog({Key? key, this.pokemon}) : super(key: key);

  @override
  State<AddPokemonDialog> createState() => _AddPokemonDialogState();
}

class _AddPokemonDialogState extends State<AddPokemonDialog> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController spriteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  TextEditingController hpController = TextEditingController();
  TextEditingController atkController = TextEditingController();
  TextEditingController defenseController = TextEditingController();
  TextEditingController specialAttackController = TextEditingController();
  TextEditingController specialDefenseController = TextEditingController();
  TextEditingController speedController = TextEditingController();

  bool autoValidate = false;

  List<String> types = [
    "Água",
    "Fogo",
    "Planta",
    "Lutador",
    "Voador",
    "Fantasma",
    "Dragão"
  ];

  List<String> selectedTypes = [];

  @override
  void initState() {
    if (widget.pokemon != null){
      loadPokemon();
    }
    super.initState();
  }

  void loadPokemon(){
    selectedTypes = widget.pokemon!.types;
    hpController.text =  widget.pokemon!.stats['hp'];
    atkController.text = widget.pokemon!.stats['attack'];
    defenseController.text = widget.pokemon!.stats['defense'];
    specialAttackController.text = widget.pokemon!.stats['special-attack'];
    specialDefenseController.text = widget.pokemon!.stats['special-defense'];
    speedController.text = widget.pokemon!.stats['speed'];
    nameController.text = widget.pokemon!.name;
    spriteController.text = widget.pokemon!.sprite;
    descriptionController.text = widget.pokemon!.description;
    weightController.text = widget.pokemon!.weight.toString();
    heightController.text = widget.pokemon!.height.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.pokemon != null ? "Editar Pokemon" : "Adicionar Pokemon", textAlign: TextAlign.center),
      content: Scrollbar(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode:
            autoValidate ? AutovalidateMode.onUserInteraction : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Tipo"),
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: 5,
                  children: [
                    for (String i in types)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedTypes.contains(i)) {
                              selectedTypes.remove(i);
                            } else {
                              if (selectedTypes.length < 3){
                                selectedTypes.add(i);
                              }
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                            color: selectedTypes.contains(i)
                                ? Colors.red.withOpacity(0.5)
                                : Colors.grey.withOpacity(0.3),
                          ),
                          child: Text(i,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              )),
                        ),
                      ),
                  ],
                ),
                const Divider(height: 25),
                Center(
                  child: Text("Status (Min 0 - Max. 99)"),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: CustomField(
                          text: "Hp",
                          controller: hpController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            LengthLimitingTextInputFormatter(2),
                          ],
                          keyboardType: TextInputType.number),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomField(
                          text: "Atk",
                          controller: atkController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            LengthLimitingTextInputFormatter(2),
                          ],
                          keyboardType: TextInputType.number),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomField(
                          text: "Defesa",
                          controller: defenseController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            LengthLimitingTextInputFormatter(2),
                          ],
                          keyboardType: TextInputType.number),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomField(
                          text: "Atk Esp.",
                          controller: specialAttackController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            LengthLimitingTextInputFormatter(2),
                          ],
                          keyboardType: TextInputType.number),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomField(
                          text: "Defesa Esp.",
                          controller: specialDefenseController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            LengthLimitingTextInputFormatter(2),
                          ],
                          keyboardType: TextInputType.number),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomField(
                          text: "Velocidade",
                          controller: speedController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            LengthLimitingTextInputFormatter(2),
                          ],
                          keyboardType: TextInputType.number),
                    )
                  ],
                ),
                const Divider(height: 25),
                CustomField(text: "Nome", controller: nameController),
                const SizedBox(height: 5),
                CustomField(text: "Sprite", controller: spriteController),
                const SizedBox(height: 5),
                CustomField(text: "Descrição", controller: descriptionController),
                const SizedBox(height: 5),
                CustomField(
                    text: "Peso",
                    controller: weightController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                      LengthLimitingTextInputFormatter(40),
                    ],
                    keyboardType: TextInputType.number),
                const SizedBox(height: 5),
                CustomField(
                    text: "Altura",
                    controller: heightController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                      LengthLimitingTextInputFormatter(40),
                    ],
                    keyboardType: TextInputType.number),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Modular.to.pop();
            },
            child: const Text("Cancelar")),
        TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (selectedTypes.isEmpty) {
                  return;
                }

                PokemonModel pokemon = PokemonModel(
                    id: widget.pokemon != null ? widget.pokemon!.id : 0,
                    name: nameController.text,
                    description: descriptionController.text,
                    sprite: spriteController.text,
                    stats: {
                      "hp": hpController.text,
                      "attack": atkController.text,
                      "defense": defenseController.text,
                      "special-attack": specialAttackController.text,
                      "special-defense": specialDefenseController.text,
                      "speed": speedController.text,
                    },
                    types: selectedTypes,
                    weight: int.parse(weightController.text),
                    height: int.parse(heightController.text)
                );

                final bloc = Modular.get<CustomPokemonsBloc>();
                if (widget.pokemon != null){
                  bloc.add(EditPokemonEvent(pokemon: pokemon));
                } else {
                  bloc.add(AddPokemonEvent(pokemon: pokemon));
                }

                Modular.to.pop();
              } else {
                setState(() {
                  autoValidate = true;
                });
              }
            },
            child: Text(widget.pokemon != null ? "Salvar" : "Criar"))
      ],
    );
  }
}
