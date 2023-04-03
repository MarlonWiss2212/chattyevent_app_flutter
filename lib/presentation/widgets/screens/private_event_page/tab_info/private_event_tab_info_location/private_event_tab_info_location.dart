import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/circle_image/cirlce_image.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/custom_divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_location/private_event_tab_info_location_data.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_location/private_event_tab_info_location_map.dart';

class PrivateEventTabInfoLocation extends StatelessWidget {
  const PrivateEventTabInfoLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        if (state.privateEvent.eventLocation != null) {
          return Column(
            children: [
              const PrivateEventTabInfoLocationData(),
              const SizedBox(height: 8),
              if (state.privateEvent.eventLocation!.latitude != null &&
                  state.privateEvent.eventLocation!.longitude != null) ...{
                const PrivateEventTabInfoLocationMap(),
              },
              const CustomDivider(),
            ],
          );
        } else if (state.privateEvent.eventLocation == null &&
            state.loadingPrivateEvent) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    width: size.width,
                    height: min(size.width, 300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
