import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:social_media_app_flutter/application/bloc/home_page/home_map_page/home_map_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

class HomeMapPage extends StatelessWidget {
  const HomeMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeMapPageCubit>(context).getLocationFromDevice();

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Social Media App'),
      ),
      body: BlocConsumer<HomeMapPageCubit, HomeMapPageState>(
        listener: (context, state) async {
          if (state is HomeMapPageError) {
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
          if (state is HomeMapPageLoading) {
            return Center(child: PlatformCircularProgressIndicator());
          } else if (state is HomeMapPageLoaded) {
            mapOptions = MapOptions(
              center: LatLng(state.lat, state.lng),
              zoom: 17,
            );
          } else {
            mapOptions = MapOptions(
              center: LatLng(47, 10),
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
                      onPressed: () =>
                          BlocProvider.of<HomeMapPageCubit>(context)
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
