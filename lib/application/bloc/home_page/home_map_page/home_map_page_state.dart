part of 'home_map_page_cubit.dart';

@immutable
abstract class HomeMapPageState {}

class HomeMapPageInitial extends HomeMapPageState {}

class HomeMapPageLoading extends HomeMapPageState {}

class HomeMapPageError extends HomeMapPageState {
  final String title;
  final String message;
  HomeMapPageError({required this.message, required this.title});
}

class HomeMapPageLoaded extends HomeMapPageState {
  final double lat;
  final double lng;

  HomeMapPageLoaded({required this.lat, required this.lng});
}
