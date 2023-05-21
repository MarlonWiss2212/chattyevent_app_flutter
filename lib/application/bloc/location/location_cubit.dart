import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/usecases/location_usecases.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationUseCases locationUseCases;
  final NotificationCubit notificationCubit;

  LocationCubit({
    required this.locationUseCases,
    required this.notificationCubit,
  }) : super(LocationInitial());

  void reset() {
    emit(LocationInitial());
  }

  Future getLocationFromDevice() async {
    emit(LocationLoading());

    final locationErrorOrLocation =
        await locationUseCases.getCurrentLocationWithPermissions();

    locationErrorOrLocation.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (location) {
        emit(
          LocationLoaded(lat: location.latitude, lng: location.longitude),
        );
      },
    );
  }
}
