abstract class HiveManager<T> {
  Future<T> create(String boxName, String id, T data);
  Future<T> read(String boxName, String id);
  Future<T> update(String boxName, String id, T data);
  Future<T> delete(String boxName, String id);
}
