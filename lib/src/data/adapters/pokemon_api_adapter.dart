import 'package:http/http.dart';

import '../../domain/interfaces/adapters/http_client_interface.dart';
import '../../domain/models/response_model.dart';

final class PokemonApiAdapter implements HttpClientInterface {
  PokemonApiAdapter() : _client = Client() {
    _baseUrl = const String.fromEnvironment('POKE_API_URL');
  }

  final Client _client;
  late String _baseUrl;

  @override
  Future<ResponseModel> get(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response = await _client.get(
      Uri.parse(_baseUrl + path).replace(queryParameters: queryParameters),
      headers: headers as Map<String, String>?,
    );
    return ResponseModel(
      body: response.body,
      headers: response.headers,
      path: path,
      queryParameters: queryParameters,
      statusCode: response.statusCode,
      statusMessage: response.reasonPhrase,
    );
  }

  @override
  Future<ResponseModel> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response = await _client.post(
      Uri.parse(_baseUrl + path).replace(queryParameters: queryParameters),
      headers: headers as Map<String, String>?,
      body: body,
    );
    return ResponseModel(
      body: response.body,
      headers: response.headers,
      path: path,
      queryParameters: queryParameters,
      statusCode: response.statusCode,
      statusMessage: response.reasonPhrase,
    );
  }

  @override
  Future<ResponseModel> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response = await _client.put(
      Uri.parse(_baseUrl + path).replace(queryParameters: queryParameters),
      headers: headers as Map<String, String>?,
      body: body,
    );
    return ResponseModel(
      body: response.body,
      headers: response.headers,
      path: path,
      queryParameters: queryParameters,
      statusCode: response.statusCode,
      statusMessage: response.reasonPhrase,
    );
  }

  @override
  Future<ResponseModel> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response = await _client.patch(
      Uri.parse(_baseUrl + path).replace(queryParameters: queryParameters),
      headers: headers as Map<String, String>?,
      body: body,
    );
    return ResponseModel(
      body: response.body,
      headers: response.headers,
      path: path,
      queryParameters: queryParameters,
      statusCode: response.statusCode,
      statusMessage: response.reasonPhrase,
    );
  }

  @override
  Future<ResponseModel> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response = await _client.delete(
      Uri.parse(_baseUrl + path).replace(queryParameters: queryParameters),
      headers: headers as Map<String, String>?,
      body: body,
    );
    return ResponseModel(
      body: response.body,
      headers: response.headers,
      path: path,
      queryParameters: queryParameters,
      statusCode: response.statusCode,
      statusMessage: response.reasonPhrase,
    );
  }
}
