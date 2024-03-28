import 'dart:io';

import 'package:flutter/foundation.dart';

/// [Classe] base para as demais classes de [Exception] da aplicação
@immutable
sealed class ExceptionModel implements Exception {
  const ExceptionModel(this.error, this.typeException, {this.statusCode, this.statusMessage});

  final dynamic error;
  final int? statusCode;
  final String? statusMessage;
  final dynamic typeException;
}

/// [Classe] para captura de erros relacionados ao servidor da aplicação
@immutable
final class ServerException extends ExceptionModel {
  const ServerException(super.error, ServerTypeException super.typeException, {super.statusCode, super.statusMessage});
}

/// [Classe] para captura de erros genéricos na aplicação
@immutable
final class GenericException extends ExceptionModel {
  const GenericException(super.error, GenericTypeException super.type, {super.statusCode, super.statusMessage});
}

/// [Enum] para identificar os tipos de erro relacionados a servidor
enum ServerTypeException {
  forbidden('Acesso negado ao servidor.', HttpStatus.forbidden),
  notFound('Requisição não encontrada.', HttpStatus.notFound),
  internalServerError('Falha ao comunicar com o servidor.', HttpStatus.internalServerError);

  const ServerTypeException(this.statusMessage, this.statusCode);

  final String statusMessage;
  final int statusCode;

  static ServerTypeException verify(int statusCode) {
    switch (statusCode) {
      case HttpStatus.forbidden:
        return ServerTypeException.forbidden;
      case HttpStatus.notFound:
        return ServerTypeException.notFound;
      default:
        return ServerTypeException.internalServerError;
    }
  }
}

/// [Enum] para identificar os tipos de erro genéricos da aplicação
enum GenericTypeException {
  search('Nenhum pokemon encontrado.', 'Tente uma nova busca pelo inicial do nome ou o número do pokemon.'),
  getLocalPokemons('PokemonStorage Error', 'Falha ao tentar carregar a lista de pokemons do banco local.'),
  setLocalPokemons('PokemonStorage Error', 'Falha ao tentar salvar a lista de pokemons no banco local.'),
  getPokemons('PokemonRepository Error', 'Falha ao tentar carregar a lista de pokemons do servidor.'),
  getPokemonByNameOrId(
    'PokemonReporitory Error',
    'Falha ao tentar consultar as informações de um pokemon no servidor.',
  );

  const GenericTypeException(this.headerMessage, this.bodyMessage);

  final String headerMessage;
  final String bodyMessage;
}
