import 'package:hive/hive.dart';

part 'auth_state_status.g.dart';

@HiveType(typeId: 3)
enum AuthStateStatus {
  @HiveField(0)
  initial,

  @HiveField(1)
  loading,

  @HiveField(2)
  loggedIn,

  @HiveField(3)
  logout,
}
