import 'package:spotstock_inventory/objectbox.g.dart'; // Ensure this file is generated correctly

class DatabaseEngine {
  Store? _store; // Use a nullable store to avoid uninitialized access

  // Private constructor for singleton pattern
  DatabaseEngine._privateConstructor();

  // Static instance of the DatabaseEngine
  static final DatabaseEngine instance = DatabaseEngine._privateConstructor();

  // Create and open the ObjectBox store
  static Future<DatabaseEngine> create() async {
    // Open the store asynchronously
    final store = await openStore();
    instance._store = store; // Assign the store to the instance
    return instance;
  }

  // Getter to access the store
  // Future<Store> getStore() async {
  //   if (_store == null) {
  //     throw Exception(
  //         'Store is not initialized. Call DatabaseEngine.create() first.');
  //   }
  //   return _store!;
  // }

  Future<Store> getStore() async {
  if (_store == null) {
    try {
      _store = await openStore();
    } catch (e) {
      print('❌ Error initializing ObjectBox store: $e');
      throw Exception('Failed to initialize database');
    }
  }
  return _store!;
}

  // General CRUD operations

  // Insert a new object
  Future<int> insert<T>(T entity) async {
    final store = await getStore(); // Wait for store to initialize
    final box = store.box<T>();
    return box.put(entity);
  }

  // Get all objects of type T
  Future<List<T>> getAll<T>() async {
    final store = await getStore(); // Wait for store to initialize
    final box = store.box<T>();
    return box.getAll();
  }

  // Update an object
  Future<void> update<T>(T entity) async {
    final store = await getStore(); // Wait for store to initialize
    final box = store.box<T>();
    box.put(entity);
  }

  // Delete an object by ID
  Future<void> delete<T>(int id) async {
    final store = await getStore(); // Wait for store to initialize
    final box = store.box<T>();
    box.remove(id);
  }

  // Count the number of objects of type T
  Future<int> count<T>() async {
    final store = await getStore(); // Wait for store to initialize
    final box = store.box<T>();
    return box.count();
  }

  // Sum a specific property of type T
  Future<double> sum<T>(double Function(T) propertyExtractor) async {
    final store = await getStore(); // Wait for store to initialize
    final box = store.box<T>();
    double total = 0;

    final allEntities = await getAll<T>(); // Ensure we await for the results
    for (var entity in allEntities) {
      total += propertyExtractor(entity);
    }

    return total;
  }

  // Query objects with a specific condition
  Future<List<T>> query<T>(Query<T> query) async {
    return query.find();
  }
}
