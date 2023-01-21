import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media_app_flutter/domain/repositories/device/image_picker_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/image_picker.dart';

class ImagePickerRepositoryImpl implements ImagePickerRepository {
  final ImagePickerDatasource imagePickerDatasource;
  ImagePickerRepositoryImpl({required this.imagePickerDatasource});

  @override
  Future<PermissionStatus> requestCameraPermission() async {
    return await imagePickerDatasource.requestCameraPermission();
  }

  @override
  Future<PermissionStatus> getCameraPermissionStatus() async {
    return await imagePickerDatasource.getCameraPermissionStatus();
  }

  @override
  Future<PermissionStatus> requestPhotosPermission() async {
    return await imagePickerDatasource.requestPhotosPermission();
  }

  @override
  Future<PermissionStatus> getPhotosPermissionStatus() async {
    return await imagePickerDatasource.getPhotosPermissionStatus();
  }

  @override
  Future<XFile?> getImageFromCamera() async {
    return await imagePickerDatasource.getImageFromCamera();
  }

  @override
  Future<XFile?> getImageFromGallery() async {
    return await imagePickerDatasource.getImageFromGallery();
  }
}
