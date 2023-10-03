part of 'home_map_cubit.dart';

class HomeMapState {
  final List<EventEntity> events;
  final LatLng? currentLocation;

  const HomeMapState({
    required this.events,
    this.currentLocation,
  });

  HomeMapState copyWith({
    List<EventEntity>? events,
    LatLng? currentLocation,
  }) {
    return HomeMapState(
      events: events ?? this.events,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }
}
