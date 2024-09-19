import 'package:get_storage/get_storage.dart';

class TlocalStorage {
  static final TlocalStorage _instance = TlocalStorage._internal();

  factory TlocalStorage() {
    return _instance;
  }

  TlocalStorage._internal() {
    _storage = GetStorage();
  }

  late final GetStorage _storage;

  // Generic method to save data
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  // Generic method to read data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }
  Future<void> clearAll() async {
    await _storage.erase();
  }
}