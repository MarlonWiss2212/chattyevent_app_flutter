import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/failures/location_failures.dart';
import 'package:social_media_app_flutter/domain/usecases/location_usecases.dart';

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
      (failure) {
        final error = mapLocationFailureToErrorWithTitleAndMessage(failure);
        notificationCubit.newAlert(
          notificationAlert: NotificationAlert(
            title: error.title,
            message: error.message,
          ),
        );
      },
      (location) {
        emit(
          LocationLoaded(lat: location.latitude, lng: location.longitude),
        );
      },
    );
  }
}
