import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/location_usecases.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/find_events_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/geocoding/geo_within_box_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/geocoding/geo_within_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/usecases/event_usecases.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'home_map_state.dart';

class HomeMapCubit extends Cubit<HomeMapState> {
  final EventUseCases eventUseCases;
  final NotificationCubit notificationCubit;
  final LocationUseCases locationUseCases;

  HomeMapCubit({
    required this.eventUseCases,
    required this.notificationCubit,
    required this.locationUseCases,
  }) : super(const HomeMapState(events: []));

  Future<void> setCurrentLocation({bool fromStorageFirst = true}) async {
    if (fromStorageFirst) {
      setCurrentLocationFromStorage();
    }

    final Either<NotificationAlert, Position> locationOrFailure =
        await locationUseCases.getCurrentLocationWithPermissions();
    locationOrFailure.fold(
      (_) => null,
      (location) => emit(
        state.copyWith(
          currentLocation: LatLng(
            location.latitude,
            location.longitude,
          ),
        ),
      ),
    );
  }

  void setCurrentLocationFromStorage() {
    final Either<NotificationAlert, LatLng> locationOrFailure =
        locationUseCases.getCurrentLocationLatLngFromStorage();

    locationOrFailure.fold(
      (_) => null,
      (latLng) => emit(state.copyWith(currentLocation: latLng)),
    );
  }

  Future<void> findEventsByLocation({
    required GeoWithinBoxFilter boxFilter,
  }) async {
    final Either<NotificationAlert, List<EventEntity>> eventOrFailure =
        await eventUseCases.getEventsViaApi(
      findEventsFilter: FindEventsFilter(
        onlyFutureEvents: true,
        locationGeoWithin: GeoWithinFilter(
          box: boxFilter,
        ),
      ),
      limitOffsetFilter: LimitOffsetFilter(
        limit: 20,
        offset: 0,
      ),
    );

    eventOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (events) => emit(HomeMapState(events: events)),
    );
  }
}
