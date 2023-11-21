import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_map/home_map_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/core/utils/maps_helper.dart';
import 'package:chattyevent_app_flutter/domain/usecases/location_usecases.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/geocoding/geo_within_box_filter.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
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
    BlocProvider.of<HomeMapCubit>(context).setCurrentLocation(
      fromStorageFirst: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("homePage.pages.mapPage.title").tr(),
      ),
      body: BlocListener<HomeMapCubit, HomeMapState>(
        listenWhen: (p, c) =>
            p.currentLocation?.latitude != c.currentLocation?.latitude ||
            p.currentLocation?.longitude != c.currentLocation?.longitude,
        listener: (context, state) {
          if (state.currentLocation == null) {
            return;
          }
          mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: state.currentLocation!,
                zoom: 12,
              ),
            ),
          );
        },
        child: BlocBuilder<HomeMapCubit, HomeMapState>(
          builder: (context, state) {
            final Set<Marker> markers = {};

            for (final event in state.events) {
              if (event.eventLocation?.geoJson?.coordinates != null) {
                markers.add(
                  Marker(
                    markerId: MarkerId(event.id),
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
                    position: LatLng(
                      event.eventLocation!.geoJson!.coordinates![1],
                      event.eventLocation!.geoJson!.coordinates![0],
                    ),
                    icon: BitmapDescriptor.defaultMarker,
                  ),
                );
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
              initialCameraPosition: state.currentLocation != null
                  ? CameraPosition(
                      target: state.currentLocation!,
                      zoom: 12,
                    )
                  : const CameraPosition(
                      target: LatLng(
                        51.165691,
                        10.451526,
                      ),
                      zoom: 8,
                    ),
            );
          },
        ),
      ),
    );
  }
}
