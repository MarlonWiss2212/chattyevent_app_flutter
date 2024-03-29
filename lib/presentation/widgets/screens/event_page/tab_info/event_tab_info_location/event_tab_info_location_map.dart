import 'dart:math';
import 'package:chattyevent_app_flutter/core/utils/maps_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skeletons/skeletons.dart';

class EventTabInfoLocationMap extends StatelessWidget {
  const EventTabInfoLocationMap({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        if (state.event.eventLocation != null &&
            state.event.eventLocation!.geoJson != null &&
            state.event.eventLocation!.geoJson!.coordinates != null) {
          return Container(
            width: size.width - 16,
            height: min(size.width - 16, 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: GoogleMap(
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
                scrollGesturesEnabled: false,
                zoomGesturesEnabled: false,
                tiltGesturesEnabled: false,
                rotateGesturesEnabled: false,
                onMapCreated: (controller) {
                  if (MediaQuery.of(context).platformBrightness ==
                      Brightness.dark) {
                    controller.setMapStyle(MapsHelper.mapStyle());
                  }
                },
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    state.event.eventLocation!.geoJson!.coordinates![1],
                    state.event.eventLocation!.geoJson!.coordinates![0],
                  ),
                  zoom: 12,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId("1"),
                    position: LatLng(
                      state.event.eventLocation!.geoJson!.coordinates![1],
                      state.event.eventLocation!.geoJson!.coordinates![0],
                    ),
                    icon: BitmapDescriptor.defaultMarker,
                  )
                },
              ),
            ),
          );
        } else if (state.loadingEvent) {
          return SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: size.width,
              height: min(size.width, 300),
              borderRadius: BorderRadius.circular(8.0),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
