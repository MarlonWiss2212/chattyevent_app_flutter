import 'package:auto_route/annotations.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_invitation_list/chat_info_page_invitation_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_update_permissions_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/custom_divider.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_description.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_leave_chat.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_private_event_list/chat_info_page_private_event_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_left_user_list/chat_info_page_left_user_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_profile_image.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_title.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_user_list/chat_info_page_user_list.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class GroupchatInfoPage extends StatefulWidget {
  const GroupchatInfoPage({
    @PathParam('id') required this.groupchatId,
    super.key,
  });
  final String groupchatId;

  @override
  State<GroupchatInfoPage> createState() => _GroupchatInfoPageState();
}

class _GroupchatInfoPageState extends State<GroupchatInfoPage> {
  @override
  void initState() {
    BlocProvider.of<CurrentGroupchatCubit>(context)
        .getFutureConnectedPrivateEventsFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 200,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: ChatInfoPageProfileImage(),
              title: ChatInfoPageTitle(),
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await Future.wait([
                BlocProvider.of<CurrentGroupchatCubit>(context)
                    .reloadGroupchatAndGroupchatUsersViaApi(),
                BlocProvider.of<CurrentGroupchatCubit>(context)
                    .getFutureConnectedPrivateEventsFromApi(reload: true),
                BlocProvider.of<CurrentGroupchatCubit>(context)
                    .getInvitationsViaApi(reload: true),
              ]);
            },
          ),
          SliverList(
            delegate: SliverChildListDelegate(const [
              SizedBox(height: 20),
              ChatInfoPageDescription(),
              CustomDivider(),
              ChatInfoPagePrivateEventList(),
              CustomDivider(),
              ChatInfoPageUserList(),
              CustomDivider(),
              ChatInfoPageLeftUserList(),
              CustomDivider(),
              ChatInfoPageInvitationList(),
              CustomDivider(),
              ChatInfoPageUpdatePermissionsListTile(),
              ChatInfoPageLeaveChat(),
            ]),
          )
        ],
      ),
    );
  }
}
