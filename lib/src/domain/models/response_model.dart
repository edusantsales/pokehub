import 'package:flutter/foundation.dart';

@immutable
final class ResponseModel {
  const ResponseModel({
    this.body,
    this.headers,
    this.path,
    this.queryParameters,
    this.statusCode,
    this.statusMessage,
  });

  /// Http response body.
  final dynamic body;

  /// Http request headers.
  final Map<String, dynamic>? headers;

  /// Http request path.
  final String? path;

  /// Http request query parameters.
  final Map<String, dynamic>? queryParameters;

  /// Http response status code.
  final int? statusCode;

  /// Returns the reason phrase associated with the status code.
  final String? statusMessage;
}
