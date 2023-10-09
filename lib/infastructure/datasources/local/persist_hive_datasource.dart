import 'package:hive/hive.dart';

abstract class PersistHiveDatasource {
  T get<T>({required String key});
  Future<void> put<T>({required String key, required T value});
}

class PersistHiveDatasourceImpl implements PersistHiveDatasource {
  final Box<dynamic> box;
  PersistHiveDatasourceImpl({
    required this.box,
  });

  @override
  T get<T>({required String key}) {
    return box.get(key);
  }

  @override
  Future<void> put<T>({required String key, required T value}) {
    return box.put(key, value);
  }
}
