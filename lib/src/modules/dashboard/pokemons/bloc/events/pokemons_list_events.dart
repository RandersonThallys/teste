abstract class PokemonsListEvent{
}

class GetPokemonListEvent extends PokemonsListEvent{}

class NextPageEvent extends PokemonsListEvent{
  final int offset;

  NextPageEvent({required this.offset});
}