import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class ImagePickerDatasource {
  Future<PermissionStatus> requestCameraPermission();
  Future<PermissionStatus> getCameraPermissionStatus();

  Future<PermissionStatus> requestPhotosPermission();
  Future<PermissionStatus> getPhotosPermissionStatus();

  Future<XFile?> getImageFromGallery();
  Future<XFile?> getImageFromCamera();
}

class ImagePickerDatasourceImpl implements ImagePickerDatasource {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  @override
  Future<PermissionStatus> getCameraPermissionStatus() async {
    return await Permission.camera.status;
  }

  @override
  Future<PermissionStatus> requestPhotosPermission() async {
    return await Permission.photos.request();
  }

  @override
  Future<PermissionStatus> getPhotosPermissionStatus() async {
    return await Permission.photos.status;
  }

  @override
  Future<XFile?> getImageFromGallery() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Future<XFile?> getImageFromCamera() async {
    return await _picker.pickImage(source: ImageSource.camera);
  }
}
