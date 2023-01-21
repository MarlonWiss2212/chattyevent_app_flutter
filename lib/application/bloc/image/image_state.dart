part of 'image_cubit.dart';

@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageError extends ImageState {
  final String title;
  final String message;
  ImageError({required this.message, required this.title});
}

class ImageLoaded extends ImageState {
  final File image;
  ImageLoaded({required this.image});
}
