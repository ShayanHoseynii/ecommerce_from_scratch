import 'package:get_storage/get_storage.dart';

class TLocalStorage {
  late final GetStorage _storage;

  // Singleton instance
  static TLocalStorage? _instance;

  // Private constructor
  TLocalStorage._internal(this._storage);

  /// Default bucket name for logged-out users
  static const String _defaultBucket = 'default_storage';

  ///
  /// Must be called in main.dart on app launch
  ///
  /// [bucketName] is optional. If null, it will use the default logged-out bucket.
  /// This method sets up the singleton instance with the specified bucket.
  static Future<void> init(String? bucketName) async {
    final finalBucketName = bucketName ?? _defaultBucket;
    // We must initialize the bucket with GetStorage before we can use it.
    await GetStorage.init(finalBucketName);
    // Create the singleton instance with its storage
    _instance = TLocalStorage._internal(GetStorage(finalBucketName));
  }

  /// Factory to get the already initialized instance
  /// Throws an exception if init() has not been called.
  factory TLocalStorage.instance() {
    if (_instance == null) {
      throw Exception(
          "TLocalStorage not initialized. Call TLocalStorage.init() in your AuthCubit or main.dart.");
    }
    return _instance!;
  }

  /// Generic method to save data
  Future<void> writeData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  /// Write data only if key doesn't exist
  Future<void> writeDataIfNull<T>(String key, T value) async {
    await _storage.writeIfNull(key, value);
  }

  /// Generic method to read data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  /// Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  /// Clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
