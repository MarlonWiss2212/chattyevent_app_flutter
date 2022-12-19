import 'package:permission_handler/permission_handler.dart';

abstract class NotificationRepository {
  Future<PermissionStatus> requestNotificationPermission();
  Future<PermissionStatus> getNotificationPermissionStatus();
}
