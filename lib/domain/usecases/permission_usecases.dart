import 'package:chattyevent_app_flutter/domain/repositories/device/permission_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUseCases {
  final PermissionRepository permissionRepository;
  PermissionUseCases({required this.permissionRepository});

  Future<PermissionStatus> requestNotificationPermission() async {
    return await permissionRepository.requestNotificationPermission();
  }

  Future<PermissionStatus> requestMicrophonePermission() async {
    return await permissionRepository.requestMicrophonePermission();
  }
}
