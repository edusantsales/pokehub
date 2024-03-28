import '../../models/pokemon_model.dart';
import '../../states/pokemon_state.dart';

abstract interface class PokemonStorageInterface {
  Future<PokemonState> getLocalPokemons(String key);
  void setLocalPokemons(String key, List<PokemonModel> values);
}
