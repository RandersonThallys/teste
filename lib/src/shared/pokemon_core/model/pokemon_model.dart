import 'dart:convert';

class PokemonModel {
  final int id;
  final String name;
  final String sprite;
  final Map<String, dynamic> stats;
  final List<String> types;
  final String description;
  final int weight;
  final int height;

  PokemonModel({
    required this.id,
    required this.name,
    required this.description,
    required this.sprite,
    required this.stats,
    required this.types,
    required this.weight,
    required this.height,
  });

  @override
  String toString() {
    return '''
      id: $id,
      name: $name,
      description: $description,
      sprite: $sprite,
      stats: $stats,
      types: $types,
      weight: $weight,
      height: $height,
     ''';
  }

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      sprite: json['sprite'],
      stats: (json['stats'] as Map<String, dynamic>?)!.map(
        (k, e) => MapEntry(k, e as int),
      ),
      types:
          (json['types'] as List<dynamic>?)!.map((e) => e as String).toList(),
      weight: json['weight'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'sprite': sprite,
        'stats': json.encode(stats),
        'types': json.encode(types),
        'weight': weight,
        'height': height,
      };
}
