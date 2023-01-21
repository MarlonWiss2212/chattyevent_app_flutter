import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:social_media_app_flutter/application/bloc/location/location_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

class HomeMapPage extends StatelessWidget {
  const HomeMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LocationCubit>(context).getLocationFromDevice();

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Social Media App'),
      ),
      body: BlocConsumer<LocationCubit, LocationState>(
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
          MapOptions mapOptions;
          if (state is LocationLoading) {
            return Center(child: PlatformCircularProgressIndicator());
          } else if (state is LocationLoaded) {
            mapOptions = MapOptions(
              center: LatLng(state.lat, state.lng),
              zoom: 17,
            );
          } else {
            mapOptions = MapOptions(
              center: LatLng(0, 0),
              zoom: 3,
            );
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
