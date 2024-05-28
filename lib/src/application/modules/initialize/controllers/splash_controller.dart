import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../domain/states/pokemon_state.dart';
import '../../../constants/local_storage_constants.dart';
import '../../../services/pokemon_service.dart';

final class SplashController {
  SplashController() : service = PokemonService();

  final PokemonService service;

  ValueNotifier<PokemonState> pokemonState = ValueNotifier<PokemonState>(LoadingPokemonState());

  Future<void> getPokemons() async {
    pokemonState.value = await service.storage.getLocalPokemons(kLocalStoragePokemonsKey);

    final DateTime startTime = DateTime.now();

    if (pokemonState.value is FailurePokemonState) {
      _loggerApiRequestStartTime(startTime);
      pokemonState.value = await service.repository.getPokemons();
      final DateTime endTime = DateTime.now();
      _loggerApiRequestEndTime(startTime, endTime);
    }
  }

  void savePokemonsOnLocalStorage() {
    if (pokemonState.value is SuccessPokemonState) {
      final SuccessPokemonState result = pokemonState.value as SuccessPokemonState;
      service.storage.setLocalPokemons(kLocalStoragePokemonsKey, result.pokemons);
    }
  }

  void _loggerApiRequestStartTime(DateTime startTime) {
    log('API REQUEST START TIME: ${startTime.hour}:${startTime.minute}:${startTime.second}');
  }

  void _loggerApiRequestEndTime(DateTime startTime, DateTime endTime) {
    log('API REQUEST END TIME: ${endTime.hour}:${endTime.minute}:${endTime.second}');
    log('API REQUEST TOTAL TIME: ${endTime.difference(startTime).inSeconds} s');
  }
}
