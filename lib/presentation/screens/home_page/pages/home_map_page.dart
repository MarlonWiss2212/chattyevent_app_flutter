import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:social_media_app_flutter/application/bloc/location/location_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/home_page/pages/home_map_page/private_event_map_marker.dart';

class Location extends StatelessWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PrivateEventCubit>(context).getPrivateEventsViaApi();
    BlocProvider.of<LocationCubit>(context).getLocationFromDevice();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) async {
          if (state is LocationError) {
            return await showDialog(
              context: context,
              builder: (c) {
                return CustomAlertDialog(
                  title: state.title,
                  message: state.message,
                  context: c,
                );
              },
            );
          }
        },
        builder: (context, state) {
          MapOptions mapOptions = MapOptions(
            interactiveFlags: InteractiveFlag.doubleTapZoom |
                InteractiveFlag.doubleTapZoom |
                InteractiveFlag.drag |
                InteractiveFlag.flingAnimation |
                InteractiveFlag.pinchMove |
                InteractiveFlag.pinchZoom,
            center: state is LocationLoaded
                ? LatLng(state.lat, state.lng)
                : LatLng(47, 10),
            zoom: state is LocationLoaded ? 14 : 3,
          );
          if (state is LocationLoading) {
            return Center(child: PlatformCircularProgressIndicator());
          }
          return Center(
            child: Stack(children: [
              FlutterMap(
                options: mapOptions,
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  BlocBuilder<PrivateEventCubit, PrivateEventState>(
                    builder: (context, state) {
                      List<Marker> markers = [];
                      for (final event in state.privateEvents) {
                        if (event.eventLocation != null &&
                            event.eventLocation!.longitude != null &&
                            event.eventLocation!.latitude != null) {
                          markers.add(
                            Marker(
                              point: LatLng(
                                event.eventLocation!.latitude!,
                                event.eventLocation!.longitude!,
                              ),
                              height: 50,
                              width: 100,
                              builder: (context) {
                                return PrivateEventMapMarker(
                                  privateEvent: event,
                                );
                              },
                            ),
                          );
                        }
                      }
                      return MarkerLayer(
                        markers: markers,
                      );
                    },
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: PlatformElevatedButton(
                      onPressed: () => BlocProvider.of<LocationCubit>(context)
                          .getLocationFromDevice(),
                      child: const Text("Geradigen Standort setzen"),
                    ),
                  ),
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}
