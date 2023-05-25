part of 'location_cubit.dart';

class LocationState {
  final double? lat;
  final double? lng;

  final bool loading;

  LocationState({this.lat, this.lng, required this.loading});

  factory LocationState.merge({
    required LocationState oldState,
    double? lat,
    double? lng,
    bool? loading,
  }) {
    return LocationState(
      loading: loading ?? oldState.loading,
      lat: lat ?? oldState.lat,
      lng: lng ?? oldState.lng,
    );
  }
}
