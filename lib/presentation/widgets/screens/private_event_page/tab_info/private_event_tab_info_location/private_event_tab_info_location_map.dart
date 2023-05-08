import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/circle_image/cirlce_image.dart';
import 'package:skeletons/skeletons.dart';

class PrivateEventTabInfoLocationMap extends StatelessWidget {
  const PrivateEventTabInfoLocationMap({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        if (state.privateEvent.eventLocation != null &&
            state.privateEvent.eventLocation!.longitude != null &&
            state.privateEvent.eventLocation!.latitude != null) {
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
                    state.privateEvent.eventLocation!.latitude!,
                    state.privateEvent.eventLocation!.longitude!,
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
                          state.privateEvent.eventLocation!.latitude!,
                          state.privateEvent.eventLocation!.longitude!,
                        ),
                        builder: (context) {
                          return CircleImage(
                            width: 40,
                            height: 40,
                            imageLink: state.privateEvent.coverImageLink,
                            icon: state.privateEvent.coverImageLink == null
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
        } else if (state.loadingPrivateEvent) {
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
