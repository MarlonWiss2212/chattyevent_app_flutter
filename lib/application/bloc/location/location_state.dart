part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationError extends LocationState {
  final String title;
  final String message;
  LocationError({required this.message, required this.title});
}

class LocationLoaded extends LocationState {
  final double lat;
  final double lng;

  LocationLoaded({required this.lat, required this.lng});
}