import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:social_media_app_flutter/domain/repositories/device/notification_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/notification.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDatasource notificationDatasource;

  NotificationRepositoryImpl({required this.notificationDatasource});

  @override
  Future<PermissionStatus> getNotificationPermissionStatus() async {
    return await notificationDatasource.getNotificationPermissionStatus();
  }

  @override
  Future<PermissionStatus> requestNotificationPermission() async {
    return await notificationDatasource.requestNotificationPermission();
  }
}
