abstract interface class LocalDatabaseInterface {
  Future<Map<String, String>> readAll();
  void write(String key, String value);
}
