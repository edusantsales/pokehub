import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/interfaces/adapters/local_storage_interface.dart';

class FlutterSecureStorageAdapter implements LocalStorageInterface {
  FlutterSecureStorageAdapter() : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  @override
  Future<Map<String, String>> readAll() async {
    final Map<String, String> map = await _storage.readAll();
    return map;
  }

  @override
  void write(String key, String value) {
    _storage.write(key: key, value: value);
  }
}
