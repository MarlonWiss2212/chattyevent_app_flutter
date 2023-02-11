import 'dart:math';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/tab_bar/info_tab/current_private_event_groupchat/connected_groupchat_widget_info_tab.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/tab_bar/info_tab/event_date_widget_info_tab.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/tab_bar/info_tab/location_widget_info_tab.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/tab_bar/info_tab/profile_image_info_tab.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/tab_bar/info_tab/user_area/user_area_widget_info_tab.dart';

class PrivateEventInfoTabDetails extends StatelessWidget {
  final CurrentPrivateEventState privateEventState;
  const PrivateEventInfoTabDetails({
    super.key,
    required this.privateEventState,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 8),
            ProfileImageWidgetInfoTab(privateEventState: privateEventState),
            const SizedBox(height: 20),
            ConnectedGroupchatWidgetInfoTab(
              privateEventState: privateEventState,
            ), // custom divider is returned in <- widget
            UserAreaWidgetInfoTab(privateEventState: privateEventState),
            const CustomDivider(),
            LocationWidgetInfoTab(
              privateEventState: privateEventState,
            ), // custom divider is returned in <- widget
            EventDateWidgetInfoTab(privateEventState: privateEventState),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
