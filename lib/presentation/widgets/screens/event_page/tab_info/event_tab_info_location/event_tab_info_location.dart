import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_location/event_tab_info_location_data.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_location/event_tab_info_location_map.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class EventTabInfoLocation extends StatelessWidget {
  const EventTabInfoLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.fit(
      crossAxisCellCount: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.surface,
        ),
        constraints: const BoxConstraints(minHeight: 50),
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CurrentEventCubit, CurrentEventState>(
          builder: (context, state) {
            return const Column(
              children: [
                EventTabInfoLocationData(),
                SizedBox(height: 8),
                EventTabInfoLocationMap(),
              ],
            );
          },
        ),
      ),
    );
  }
}
