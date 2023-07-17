import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latlong2/latlong.dart';

class ChatMessageInputCurrentLocation extends StatelessWidget {
  const ChatMessageInputCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: BlocBuilder<AddMessageCubit, AddMessageState>(
        buildWhen: (p, c) => p.lat != c.lat || p.lon != c.lon,
        builder: (context, state) {
          if (state.lat != null && state.lon != null) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 100,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        FlutterMap(
                          options: MapOptions(
                            interactiveFlags: InteractiveFlag.none,
                            center: LatLng(state.lat!, state.lon!),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(state.lat!, state.lon!),
                                  builder: (context) {
                                    return Icon(
                                      Ionicons.location,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xCC000000),
                                Color(0x00000000),
                                Color(0x00000000),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () =>
                                  BlocProvider.of<AddMessageCubit>(context)
                                      .emitState(removeCurrentLocation: true),
                              child: const Icon(Ionicons.close),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
