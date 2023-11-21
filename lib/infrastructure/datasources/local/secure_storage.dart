import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageDatasource {
  Future<String?> read({required String key});
  Future<void> write({required String key, required String? value});
}

class SecureStorageDatasourceImpl implements SecureStorageDatasource {
  final FlutterSecureStorage flutterSecureStorage;
  SecureStorageDatasourceImpl({required this.flutterSecureStorage});

  @override
  Future<String?> read({required String key}) {
    return flutterSecureStorage.read(key: key);
  }

  @override
  Future<void> write({required String key, required String? value}) {
    return flutterSecureStorage.write(key: key, value: value);
  }
}
