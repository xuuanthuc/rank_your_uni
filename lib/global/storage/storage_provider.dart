import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class StorageProvider {
  final FlutterSecureStorage _storage;

  const StorageProvider(this._storage);

  static StorageProvider get instance => const StorageProvider(FlutterSecureStorage());

  Future<String?> get(String key) async {
    final data = await _storage.read(key: key);
    return data;
  }

  Future<void> save(String key, String value) async{
    await _storage.write(key: key, value: value);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
