import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:latlong2/latlong.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/location/location_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/ad_helper.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/ads/custom_native_ad.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/home_page/pages/home_map_page/private_event_map_marker.dart';

class HomeMapPage extends StatefulWidget {
  const HomeMapPage({super.key});

  @override
  State<HomeMapPage> createState() => _HomeMapPageState();
}

class _HomeMapPageState extends State<HomeMapPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeEventCubit>(context).getFuturePrivateEventsViaApi();
    BlocProvider.of<LocationCubit>(context).getLocationFromDevice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Event Karte'),
      ),
      body: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          MapOptions mapOptions = MapOptions(
            interactiveFlags: InteractiveFlag.doubleTapZoom |
                InteractiveFlag.doubleTapZoom |
                InteractiveFlag.drag |
                InteractiveFlag.flingAnimation |
                InteractiveFlag.pinchMove |
                InteractiveFlag.pinchZoom,
            center: state.lat != null && state.lng != null
                ? LatLng(state.lat!, state.lng!)
                : LatLng(47, 10),
            zoom: state.lat != null && state.lng != null ? 14 : 3,
          );
          return Center(
            child: Stack(
              children: [
                FlutterMap(
                  options: mapOptions,
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    //TODO change to own cubit
                    BlocBuilder<HomeEventCubit, HomeEventState>(
                      builder: (context, state) {
                        List<Marker> markers = [];
                        for (final eventState in state.futurePrivateEvents) {
                          if (eventState.privateEvent.eventLocation != null &&
                              eventState.privateEvent.eventLocation!
                                      .geoJsonLocation !=
                                  null &&
                              eventState.privateEvent.eventLocation!
                                      .geoJsonLocation!.coordinates !=
                                  null) {
                            markers.add(
                              Marker(
                                point: LatLng(
                                  eventState.privateEvent.eventLocation!
                                      .geoJsonLocation!.coordinates![1],
                                  eventState.privateEvent.eventLocation!
                                      .geoJsonLocation!.coordinates![0],
                                ),
                                height: 50,
                                width: 100,
                                builder: (context) {
                                  return PrivateEventMapMarker(
                                    privateEventState: eventState,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomNativeAd(
                        adUnitId: AdHelper.mapTabNativeAdUnitId,
                        maxWidth: MediaQuery.of(context).size.width,
                        minWidth: MediaQuery.of(context).size.width,
                        maxHeight: 90,
                        minHeight: 80,
                        templateType: TemplateType.small,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Button(
                            onTap: () => BlocProvider.of<LocationCubit>(context)
                                .getLocationFromDevice(),
                            text: "Geradigen Standort setzen",
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
