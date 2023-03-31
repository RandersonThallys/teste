import 'package:flutter/material.dart';

class PokemonField extends StatelessWidget {
  String title;
  String description;

  PokemonField({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(title,
                style:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 8,
            child: Text(description,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 15,
                )),
          ),
        ],
      ),
    );
  }
}
