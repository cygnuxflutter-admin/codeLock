abstract class DBHelperMethod<T> {
  Future<int> insert(T data, String table);
  Future<int> update(T data, String table);
  Future<int> delete(int data, String table);
  Future<List<T>> query(String value);
}
