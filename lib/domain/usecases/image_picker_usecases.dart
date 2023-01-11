import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media_app_flutter/domain/repositories/device/image_picker_repository.dart';

class ImagePickerUseCases {
  final ImagePickerRepository imagePickerRepository;
  ImagePickerUseCases({required this.imagePickerRepository});

  Future<PermissionStatus> requestCameraPermission() async {
    return await imagePickerRepository.requestCameraPermission();
  }

  Future<PermissionStatus> getCameraPermissionStatus() async {
    return await imagePickerRepository.getCameraPermissionStatus();
  }

  Future<PermissionStatus> requestPhotosPermission() async {
    return await imagePickerRepository.requestPhotosPermission();
  }

  Future<PermissionStatus> getPhotosPermissionStatus() async {
    return await imagePickerRepository.getPhotosPermissionStatus();
  }

  Future<XFile?> getImageFromGallery() async {
    return await imagePickerRepository.getImageFromGallery();
  }

  Future<XFile?> getImageFromCamera() async {
    return await imagePickerRepository.getImageFromCamera();
  }
}
