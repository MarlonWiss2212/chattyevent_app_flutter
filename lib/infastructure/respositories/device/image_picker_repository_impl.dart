import 'package:image_picker/image_picker.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/image_picker_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/image_picker.dart';

class ImagePickerRepositoryImpl implements ImagePickerRepository {
  final ImagePickerDatasource imagePickerDatasource;
  ImagePickerRepositoryImpl({required this.imagePickerDatasource});

  @override
  Future<XFile?> getImageFromCamera() async {
    return await imagePickerDatasource.getImageFromCamera();
  }

  @override
  Future<XFile?> getImageFromGallery() async {
    return await imagePickerDatasource.getImageFromGallery();
  }
}
