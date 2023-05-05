import 'package:permission_handler/permission_handler.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/notification_repository.dart';

class NotificationUseCases {
  final NotificationRepository notificationRepository;
  NotificationUseCases({required this.notificationRepository});

  Future<PermissionStatus> getNotificationPermissionStatus() async {
    return await notificationRepository.getNotificationPermissionStatus();
  }

  Future<PermissionStatus> requestNotificationPermission() async {
    return await notificationRepository.requestNotificationPermission();
  }
}
