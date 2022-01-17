abstract class Storage {
  Future<dynamic> read(String key);

  Future<dynamic> save(String key, value);

  Future<dynamic> remove(String key);
}
