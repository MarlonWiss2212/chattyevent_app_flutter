import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_connected_groupchat/private_event_tab_info_connected_groupchat.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_cover_image.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_event_date.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_location/private_event_tab_info_location.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_user_list/private_event_tab_info_user_list.dart';

class PrivateEventTabInfo extends StatelessWidget {
  final String privateEventId;
  const PrivateEventTabInfo({
    @PathParam('id') required this.privateEventId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => BlocProvider.of<CurrentPrivateEventCubit>(context)
          .getPrivateEventAndGroupchatFromApi(),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 8),
            PrivateEventTabInfoCoverImage(),
            SizedBox(height: 20),
            PrivateEventTabInfoGroupchatTo(),
            CustomDivider(),
            PrivateEventTabInfoUserList(),
            CustomDivider(),
            PrivateEventTabInfoLocation(), // custom divider is returned in <- widget
            PrivateEventTabInfoEventDate(),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
