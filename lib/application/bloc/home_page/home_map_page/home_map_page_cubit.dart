import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/failures/location_failures.dart';
import 'package:social_media_app_flutter/domain/usecases/location_usecases.dart';

part 'home_map_page_state.dart';

class HomeMapPageCubit extends Cubit<HomeMapPageState> {
  final LocationUseCases locationUseCases;

  HomeMapPageCubit({required this.locationUseCases})
      : super(HomeMapPageInitial());

  Future getLocationFromDevice() async {
    emit(HomeMapPageLoading());

    final locationErrorOrLocation =
        await locationUseCases.getCurrentLocationWithPermissions();

    locationErrorOrLocation.fold(
      (failure) {
        final error = mapLocationFailureToErrorWithTitleAndMessage(failure);
        emit(HomeMapPageError(message: error.message, title: error.title));
      },
      (location) {
        emit(
          HomeMapPageLoaded(lat: location.latitude, lng: location.longitude),
        );
      },
    );
  }
}
