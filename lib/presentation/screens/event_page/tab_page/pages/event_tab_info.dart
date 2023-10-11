import 'package:auto_route/annotations.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_connected_groupchat/event_tab_info_connected_groupchat.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_update_permissions_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_cover_image.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_description.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_event_date.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_location/event_tab_info_location.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventTabInfo extends StatelessWidget {
  const EventTabInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () => BlocProvider.of<CurrentEventCubit>(context)
              .reloadEventStandardDataViaApi(),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            const [
              EventTabInfoCoverImage(),
              SizedBox(height: 20),
              EventTabInfoDescription(),
              EventTabInfoGroupchatTo(),
              EventTabInfoEventDate(),
              EventTabInfoStatus(),
              EventTabInfoLocation(),
              EventTabInfoUpdatePermissionsListTile(),
              SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
