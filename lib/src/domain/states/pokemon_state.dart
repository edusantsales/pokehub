import '../models/exception_model.dart';
import '../models/pokemon_model.dart';

sealed class PokemonState {}

final class LoadingPokemonState implements PokemonState {}

final class FailurePokemonState implements PokemonState {
  FailurePokemonState(this.e);

  final ExceptionModel e;
}

final class SuccessPokemonState implements PokemonState {
  SuccessPokemonState(this.pokemons);

  final List<PokemonModel> pokemons;
}
