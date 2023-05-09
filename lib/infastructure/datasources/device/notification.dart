import 'package:permission_handler/permission_handler.dart';

abstract class NotificationDatasource {
  Future<PermissionStatus> requestNotificationPermission();
  Future<PermissionStatus> getNotificationPermissionStatus();
}

class NotificationDatasourceImpl implements NotificationDatasource {
  @override
  Future<PermissionStatus> requestNotificationPermission() async {
    return await Permission.notification.request();
  }

  @override
  Future<PermissionStatus> getNotificationPermissionStatus() async {
    return await Permission.notification.status;
  }
}
