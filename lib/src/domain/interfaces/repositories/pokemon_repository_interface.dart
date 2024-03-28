import '../../models/pokemon_model.dart';
import '../../states/pokemon_state.dart';

abstract interface class PokemonRepositoryInterface {
  Future<PokemonState> getPokemons({String offset, String limit});
  Future<PokemonModel> getPokemonByNameOrId(String nameOrId);
}
