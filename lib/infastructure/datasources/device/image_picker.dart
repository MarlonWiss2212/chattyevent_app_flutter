import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerDatasource {
  Future<XFile?> getImageFromGallery();
  Future<XFile?> getImageFromCamera();
  Future<CroppedFile?> cropImage({
    required String sourcePath,
    int compressQuality = 50,
    CropAspectRatio? aspectRatio,
  });
}

class ImagePickerDatasourceImpl implements ImagePickerDatasource {
  final ImagePicker imagePicker;
  final ImageCropper imageCropper;
  ImagePickerDatasourceImpl({required this.imagePicker,required this.imageCropper,});

  @override
  Future<XFile?> getImageFromGallery() async {
    return await imagePicker.pickImage(source: ImageSource.gallery);
  }

  @override
  Future<XFile?> getImageFromCamera() async {
    return await imagePicker.pickImage(source: ImageSource.camera);
  }
  
  @override
  Future<CroppedFile?> cropImage({
    required String sourcePath,
    int compressQuality = 50,
    CropAspectRatio? aspectRatio,
  }) async {
    return await imageCropper.cropImage(
      sourcePath: sourcePath,
      compressQuality: compressQuality,
      aspectRatio: aspectRatio,
    );
  }
}
