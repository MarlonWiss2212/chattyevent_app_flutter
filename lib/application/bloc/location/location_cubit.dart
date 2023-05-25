import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/usecases/location_usecases.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationUseCases locationUseCases;
  final NotificationCubit notificationCubit;

  LocationCubit({
    required this.locationUseCases,
    required this.notificationCubit,
  }) : super(LocationState(loading: false));

  Future getLocationFromDevice() async {
    emit(LocationState.merge(oldState: state, loading: true));

    final locationErrorOrLocation =
        await locationUseCases.getCurrentLocationWithPermissions();

    locationErrorOrLocation.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(LocationState.merge(oldState: state, loading: false));
      },
      (location) {
        emit(LocationState.merge(
          oldState: state,
          loading: false,
          lat: location.latitude,
          lng: location.longitude,
        ));
      },
    );
  }
}
