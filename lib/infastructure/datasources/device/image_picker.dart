import 'dart:io';
import 'dart:typed_data';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart';

abstract class ImagePickerDatasource {
  Future<XFile?> getImageFromGallery();
  Future<XFile?> getImageFromCamera();
  Future<CroppedFile?> cropImage({
    required String sourcePath,
    int compressQuality = 100,
    CropAspectRatio? aspectRatio,
  });
  Future<File> convertPngToJpeg({
    required Image image,
    required String oldPath,
  });
  Future<Image?> fileToImage({
    required File file,
  });
}

class ImagePickerDatasourceImpl implements ImagePickerDatasource {
  final ImagePicker imagePicker;
  final ImageCropper imageCropper;
  ImagePickerDatasourceImpl({
    required this.imagePicker,
    required this.imageCropper,
  });

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
    int compressQuality = 100,
    CropAspectRatio? aspectRatio,
  }) async {
    return await imageCropper.cropImage(
      sourcePath: sourcePath,
      compressQuality: compressQuality,
      aspectRatio: aspectRatio,
    );
  }

  @override
  Future<File> convertPngToJpeg({
    required Image image,
    required String oldPath,
  }) async {
    final outputFilePath =
        oldPath.contains(".jpg") ? oldPath : "${oldPath.split(".png")[0]}.jpg";

    final jpegData = encodeJpg(image, quality: 35);

    final outputFile = File(outputFilePath);
    return await outputFile.writeAsBytes(jpegData);
  }

  @override
  Future<Image?> fileToImage({required File file}) async {
    final inputBytes = await file.readAsBytes();
    return decodeImage(Uint8List.fromList(inputBytes));
  }
}
