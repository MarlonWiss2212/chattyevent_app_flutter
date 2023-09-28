import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_map/home_map_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/core/utils/maps_helper.dart';
import 'package:chattyevent_app_flutter/domain/usecases/location_usecases.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/geocoding/geo_within_box_filter.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomeMapPage extends StatefulWidget {
  const HomeMapPage({super.key});

  @override
  State<HomeMapPage> createState() => _HomeMapPageState();
}

class _HomeMapPageState extends State<HomeMapPage> {
  final NotificationCubit notificationCubit = serviceLocator();
  final LocationUseCases locationUseCases = serviceLocator();
  GoogleMapController? mapController;

  void onCameraIdle() async {
    final LatLngBounds? visibleRegion = await mapController?.getVisibleRegion();

    if (visibleRegion != null) {
      // ignore: use_build_context_synchronously
      BlocProvider.of<HomeMapCubit>(context).findEventsByLocation(
        boxFilter: GeoWithinBoxFilter(
          upperRightCoordinates: [
            visibleRegion.northeast.longitude,
            visibleRegion.northeast.latitude
          ],
          bottomLeftCoordinates: [
            visibleRegion.southwest.longitude,
            visibleRegion.southwest.latitude
          ],
        ),
      );
    }
  }

  Future<void> onMapCreated(controller) async {
    mapController = controller;
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      controller.setMapStyle(MapsHelper.mapStyle());
    }

    final locationOrFailure =
        await locationUseCases.getCurrentLocationWithPermissions();
    locationOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (location) {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                location.latitude,
                location.longitude,
              ),
              zoom: 12,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeMapCubit, HomeMapState>(
        builder: (context, state) {
          final Set<Marker> markers = {};

          for (final event in state.events) {
            if (event.eventLocation?.geoJson?.coordinates != null) {
              markers.add(Marker(
                markerId: MarkerId(event.id),
                position: LatLng(
                  event.eventLocation!.geoJson!.coordinates![1],
                  event.eventLocation!.geoJson!.coordinates![0],
                ),
                onTap: () {
                  AutoRouter.of(context).push(
                    EventWrapperRoute(
                      eventId: event.id,
                      eventStateToSet: CurrentEventState.fromEvent(
                        event: event,
                      ),
                    ),
                  );
                },
                icon: BitmapDescriptor.defaultMarker,
              ));
            }
          }

          return GoogleMap(
            mapToolbarEnabled: false,
            tiltGesturesEnabled: false,
            rotateGesturesEnabled: false,
            onCameraIdle: onCameraIdle,
            onMapCreated: onMapCreated,
            markers: markers,
            mapType: MapType.normal,
            initialCameraPosition: const CameraPosition(
              target: LatLng(
                51.165691,
                10.451526,
              ),
              zoom: 8,
            ),
          );
        },
      ),
    );
  }
}
