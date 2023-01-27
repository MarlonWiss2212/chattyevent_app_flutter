import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:social_media_app_flutter/application/bloc/location/location_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/add_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/private_event/create_location_private_event_dto.dart';
import 'package:social_media_app_flutter/domain/dto/private_event/create_private_event_dto.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/cirlce_image.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

class NewPrivateEventLocationPage extends StatefulWidget {
  final DateTime date;
  final String title;
  final File image;
  final GroupchatEntity selectedGroupchat;
  const NewPrivateEventLocationPage({
    super.key,
    required this.date,
    required this.image,
    required this.selectedGroupchat,
    required this.title,
  });

  @override
  State<NewPrivateEventLocationPage> createState() =>
      _NewPrivateEventLocationPageState();
}

class _NewPrivateEventLocationPageState
    extends State<NewPrivateEventLocationPage> {
  CreatePrivateEventLocationDto? eventLocation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Neues Event Location (Optional)'),
      ),
      body: Column(
        children: [
          BlocBuilder<AddPrivateEventCubit, AddPrivateEventState>(
              builder: (context, state) {
            if (state is AddPrivateEventLoading) {
              return const LinearProgressIndicator();
            }
            return Container();
          }),
          Expanded(
            child: BlocConsumer<LocationCubit, LocationState>(
              listener: (context, state) async {
                if (state is LocationError) {
                  return await showPlatformDialog(
                    context: context,
                    builder: (context) {
                      return PlatformAlertDialog(
                        title: Text(state.title),
                        content: Text(state.message),
                        actions: const [OKButton()],
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                MapOptions mapOptions = MapOptions(
                  center: state is LocationLoaded
                      ? LatLng(state.lat, state.lng)
                      : LatLng(47, 10),
                  rotationThreshold: 400,
                  zoom: state is LocationLoaded ? 14 : 3,
                  onTap: (tapPosition, point) {
                    setState(() {
                      eventLocation = CreatePrivateEventLocationDto(
                        latitude: point.latitude,
                        longitude: point.longitude,
                      );
                    });
                  },
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
                        MarkerLayer(
                          markers: [
                            if (eventLocation != null) ...{
                              Marker(
                                point: LatLng(
                                  eventLocation!.latitude,
                                  eventLocation!.longitude,
                                ),
                                builder: (context) {
                                  return CircleImage(
                                    width: 40,
                                    height: 40,
                                    image: widget.image,
                                  );
                                },
                              ),
                            }
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: PlatformElevatedButton(
                            onPressed: () =>
                                BlocProvider.of<LocationCubit>(context)
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: PlatformElevatedButton(
                onPressed: () async {
                  BlocProvider.of<AddPrivateEventCubit>(context)
                      .createPrivateEvent(
                    createPrivateEventDto: CreatePrivateEventDto(
                      title: widget.title,
                      eventDate: widget.date,
                      connectedGroupchat: widget.selectedGroupchat.id,
                      coverImage: widget.image,
                      eventLocation: eventLocation,
                    ),
                  );
                },
                child: const Text("Speichern"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
