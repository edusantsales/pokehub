import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../../domain/interfaces/adapters/http_client_interface.dart';
import '../../domain/interfaces/repositories/pokemon_repository_interface.dart';
import '../../domain/models/exception_model.dart';
import '../../domain/models/pokemon_model.dart';
import '../../domain/models/response_model.dart';
import '../../domain/states/pokemon_state.dart';

final class PokemonRepository implements PokemonRepositoryInterface {
  PokemonRepository(this._client);

  final HttpClientInterface _client;

  void _loggerGeneric(GenericException ge) {
    final GenericTypeException type = ge.typeException as GenericTypeException;
    log('==================== ${type.headerMessage} ====================');
    log(ge.error.toString());
    log(type.bodyMessage);
    log('==============================================================');
  }

  void _loggerServer(ServerException se) {
    final ServerTypeException type = se.typeException as ServerTypeException;
    log('==================== ${type.statusMessage} ====================');
    log(se.error.toString());
    log(se.statusMessage.toString());
    log(se.statusCode.toString());
    log(type.statusCode.toString());
    log('==============================================================');
  }

  /// O valor máximo para o parâmetro [limit] deve ser [920], pois é a quantidade de pokemons com animação na API
  @override
  Future<PokemonState> getPokemons({String offset = '0', String limit = '920'}) async {
    try {
      final ResponseModel response = await _client.get(
        '/pokemon',
        queryParameters: <String, dynamic>{'offset': offset, 'limit': limit},
      );
      final Map<String, dynamic> json = jsonDecode(response.body as String) as Map<String, dynamic>;
      final List<dynamic> results = json['results'] as List<dynamic>;
      final List<String> names = results.map((dynamic e) => e['name'] as String).toList();
      final List<PokemonModel> pokemons = <PokemonModel>[];
      final List<Future<PokemonModel>> futures = <Future<PokemonModel>>[];

      for (final String name in names) {
        futures.add(getPokemonByNameOrId(name));
      }

      pokemons.addAll(await Future.wait(futures));

      return SuccessPokemonState(pokemons);
    } on HttpResponse catch (e) {
      final ServerException se = ServerException(
        e,
        ServerTypeException.verify(e.statusCode),
        statusCode: e.statusCode,
        statusMessage: e.reasonPhrase,
      );
      final GenericException ge = GenericException(e, GenericTypeException.getPokemons);
      _loggerServer(se);
      _loggerGeneric(ge);
      return FailurePokemonState(se);
    } catch (e) {
      final GenericException ge = GenericException(e, GenericTypeException.getPokemons);
      _loggerGeneric(ge);
      return FailurePokemonState(ge);
    }
  }

  @override
  Future<PokemonModel> getPokemonByNameOrId(String nameOrId) async {
    try {
      final ResponseModel response = await _client.get('/pokemon/$nameOrId');
      final PokemonModel pokemon = PokemonModel.fromJson(response.body as String);
      return pokemon;
    } on HttpResponse catch (e) {
      final ServerException se = ServerException(
        e,
        ServerTypeException.verify(e.statusCode),
        statusCode: e.statusCode,
        statusMessage: e.reasonPhrase,
      );
      final GenericException ge = GenericException(e, GenericTypeException.getPokemonByNameOrId);
      _loggerServer(se);
      _loggerGeneric(ge);
      throw se;
    } catch (e) {
      final GenericException ge = GenericException(e, GenericTypeException.getPokemonByNameOrId);
      _loggerGeneric(ge);
      throw ge;
    }
  }
}
