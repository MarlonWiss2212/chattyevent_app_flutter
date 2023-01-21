import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/failures/location_failures.dart';
import 'package:social_media_app_flutter/domain/usecases/location_usecases.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationUseCases locationUseCases;

  LocationCubit({required this.locationUseCases}) : super(LocationInitial());

  Future getLocationFromDevice() async {
    emit(LocationLoading());

    final locationErrorOrLocation =
        await locationUseCases.getCurrentLocationWithPermissions();

    locationErrorOrLocation.fold(
      (failure) {
        final error = mapLocationFailureToErrorWithTitleAndMessage(failure);
        emit(LocationError(message: error.message, title: error.title));
      },
      (location) {
        emit(LocationLoaded(lat: location.latitude, lng: location.longitude));
      },
    );
  }
}
