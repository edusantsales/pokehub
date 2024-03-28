import 'package:flutter/foundation.dart';

import '../../../../domain/states/pokemon_state.dart';
import '../../../constants/local_storage_constants.dart';
import '../../../services/data_service.dart';

class PokedexController {
  PokedexController() : dataService = DataService();

  final DataService dataService;

  ValueNotifier<PokemonState> pokemonState = ValueNotifier<PokemonState>(LoadingPokemonState());
  ValueNotifier<bool> pokemonImageState = ValueNotifier<bool>(false);

  Future<void> getPokemons() async {
    pokemonState.value = await dataService.pokemonStorage.getLocalPokemons(kLocalStoragePokemonsKey);
  }

  void setPokemonImage3d() {
    pokemonImageState.value = !pokemonImageState.value;
  }
}
