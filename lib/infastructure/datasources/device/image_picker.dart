import 'package:image_picker/image_picker.dart';

abstract class ImagePickerDatasource {
  Future<XFile?> getImageFromGallery();
  Future<XFile?> getImageFromCamera();
}

class ImagePickerDatasourceImpl implements ImagePickerDatasource {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<XFile?> getImageFromGallery() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Future<XFile?> getImageFromCamera() async {
    return await _picker.pickImage(source: ImageSource.camera);
  }
}
