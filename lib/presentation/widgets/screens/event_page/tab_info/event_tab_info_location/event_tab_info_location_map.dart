import 'dart:math';
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
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: min(size.width, 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: GoogleMap(
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: size.width,
                height: min(size.width, 300),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
