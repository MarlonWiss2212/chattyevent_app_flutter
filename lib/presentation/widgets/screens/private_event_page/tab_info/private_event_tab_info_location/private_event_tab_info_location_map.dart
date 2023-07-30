import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/circle_image/cirlce_image.dart';
import 'package:skeletons/skeletons.dart';

class PrivateEventTabInfoLocationMap extends StatelessWidget {
  const PrivateEventTabInfoLocationMap({super.key});

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
              child: FlutterMap(
                options: MapOptions(
                  interactiveFlags: InteractiveFlag.none,
                  center: LatLng(
                    state.event.eventLocation!.geoJson!.coordinates![1],
                    state.event.eventLocation!.geoJson!.coordinates![0],
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(
                          state.event.eventLocation!.geoJson!.coordinates![1],
                          state.event.eventLocation!.geoJson!.coordinates![0],
                        ),
                        builder: (context) {
                          return CircleImage(
                            width: 40,
                            height: 40,
                            imageLink: state.event.coverImageLink,
                            icon: state.event.coverImageLink == null
                                ? const Icon(Icons.celebration)
                                : null,
                          );
                        },
                      ),
                    ],
                  ),
                ],
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
