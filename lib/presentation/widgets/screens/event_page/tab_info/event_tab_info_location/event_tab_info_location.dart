import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_location/event_tab_info_location_data.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_location/event_tab_info_location_map.dart';

class EventTabInfoLocation extends StatelessWidget {
  const EventTabInfoLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        return const Column(
          children: [
            EventTabInfoLocationData(),
            SizedBox(height: 8),
            EventTabInfoLocationMap(),
          ],
        );
      },
    );
  }
}
