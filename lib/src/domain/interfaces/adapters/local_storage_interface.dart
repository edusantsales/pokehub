abstract interface class LocalStorageInterface {
  Future<Map<String, String>> readAll();
  void write(String key, String value);
}
