import 'dart:math';
import 'package:auto_route/annotations.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_connected_groupchat/event_tab_info_connected_groupchat.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_update_permissions_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/custom_divider.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_cover_image.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_description.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_event_date.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_event_end_date.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_location/event_tab_info_location.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_status.dart';

@RoutePage()
class EventTabInfo extends StatelessWidget {
  const EventTabInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        pinned: true,
        snap: true,
        floating: true,
        toolbarHeight: 0,
        expandedHeight: min(
          (MediaQuery.of(context).size.width / 4 * 3),
          (MediaQuery.of(context).size.height / 2),
        ),
        centerTitle: true,
        flexibleSpace: const FlexibleSpaceBar(
          centerTitle: true,
          background: EventTabInfoCoverImage(),
        ),
      ),
      CupertinoSliverRefreshControl(
        onRefresh: () => BlocProvider.of<CurrentEventCubit>(context)
            .reloadEventStandardDataViaApi(),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          const SizedBox(height: 20),
          const EventTabInfoDescription(),
          const EventTabInfoGroupchatTo(),
          const CustomDivider(),
          const EventTabInfoEventDate(),
          const PrivateEventTabInfoEventEndDate(),
          const EventTabInfoStatus(),
          const CustomDivider(),
          const EventTabInfoLocation(),
          const EventTabInfoUpdatePermissionsListTile(),
          const SizedBox(height: 8),
        ]),
      )
    ]);
  }
}
