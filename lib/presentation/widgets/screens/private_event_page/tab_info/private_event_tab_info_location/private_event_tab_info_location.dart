import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/custom_divider.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_location/private_event_tab_info_location_data.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_location/private_event_tab_info_location_map.dart';

class PrivateEventTabInfoLocation extends StatelessWidget {
  const PrivateEventTabInfoLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        return const Column(
          children: [
            PrivateEventTabInfoLocationData(),
            SizedBox(height: 8),
            PrivateEventTabInfoLocationMap(),
            CustomDivider(),
          ],
        );
      },
    );
  }
}
