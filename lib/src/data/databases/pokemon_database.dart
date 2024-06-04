import 'dart:convert';
import 'dart:developer';

import '../../domain/interfaces/adapters/local_database_interface.dart';
import '../../domain/interfaces/databases/pokemon_database_interface.dart';
import '../../domain/models/exception_model.dart';
import '../../domain/models/pokemon_model.dart';
import '../../domain/states/pokemon_state.dart';

class PokemonDatabase implements PokemonDatabaseInterface {
  PokemonDatabase(this._storage);

  final LocalDatabaseInterface _storage;

  void _logger(GenericException ge) {
    final GenericTypeException type = ge.typeException as GenericTypeException;
    log('==================== ${type.headerMessage} ====================');
    log(ge.error.toString());
    log(type.bodyMessage);
    log('==============================================================');
  }

  @override
  Future<PokemonState> getLocalPokemons(String key) async {
    try {
      final Map<String, String> values = await _storage.readAll();
      final List<dynamic> results = jsonDecode(values[key]!) as List<dynamic>;
      final List<PokemonModel> pokemons = results.map((dynamic e) {
        return PokemonModel(
          id: e['id'] as int,
          name: e['name'] as String,
          sprites: List<String>.from(e['sprites'] as List<dynamic>),
          types: List<String>.from(e['types'] as List<dynamic>),
        );
      }).toList();
      return SuccessPokemonState(pokemons);
    } catch (e) {
      final GenericException ge = GenericException(e, GenericTypeException.getLocalPokemons);
      _logger(ge);
      return FailurePokemonState(ge);
    }
  }

  @override
  void setLocalPokemons(String key, List<PokemonModel> values) {
    try {
      final List<String> list = values.map((PokemonModel e) => e.toJson()).toList();
      _storage.write(key, list.toString());
    } catch (e) {
      final GenericException ge = GenericException(e, GenericTypeException.setLocalPokemons);
      _logger(ge);
    }
  }
}
