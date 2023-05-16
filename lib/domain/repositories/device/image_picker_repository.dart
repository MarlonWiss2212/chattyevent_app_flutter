import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class ImagePickerRepository {
  Future<PermissionStatus> requestCameraPermission();
  Future<PermissionStatus> getCameraPermissionStatus();

  Future<PermissionStatus> requestPhotosPermission();
  Future<PermissionStatus> getPhotosPermissionStatus();

  Future<XFile?> getImageFromGallery();
  Future<XFile?> getImageFromCamera();

  Future<CroppedFile?> cropImage({
    required String sourcePath,
    required int compressQuality,
    required CropAspectRatio aspectRatio,
  });
}
