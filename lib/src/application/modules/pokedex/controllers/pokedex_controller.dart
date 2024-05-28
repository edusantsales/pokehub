import 'package:flutter/foundation.dart';

import '../../../../domain/states/pokemon_state.dart';
import '../../../constants/local_storage_constants.dart';
import '../../../services/pokemon_service.dart';

class PokedexController {
  PokedexController() : service = PokemonService();

  final PokemonService service;

  ValueNotifier<PokemonState> pokemonState = ValueNotifier<PokemonState>(LoadingPokemonState());
  ValueNotifier<bool> pokemonImageState = ValueNotifier<bool>(false);

  Future<void> getPokemons() async {
    pokemonState.value = await service.storage.getLocalPokemons(kLocalStoragePokemonsKey);
  }

  void setPokemonImage3d() {
    pokemonImageState.value = !pokemonImageState.value;
  }
}
