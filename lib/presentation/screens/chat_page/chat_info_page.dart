import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/custom_divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_description.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_leave_chat.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_private_event_list/chat_info_page_private_event_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_left_user_list/chat_info_page_left_user_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_profile_image.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_title.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_user_list/chat_info_page_user_list.dart';

class ChatInfoPage extends StatelessWidget {
  const ChatInfoPage({@PathParam('id') required this.groupchatId, super.key});
  final String groupchatId;

  @override
  Widget build(BuildContext context) {
    // should get the private events for this chat in future for more effeciancy
    BlocProvider.of<CurrentChatCubit>(context)
        .getFutureConnectedPrivateEventsFromApi(
      limitOffsetFilter: LimitOffsetFilter(
        limit: 10,
        offset: 0,
      ),
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: ChatInfoPageProfileImage(),
              title: ChatInfoPageTitle(),
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await Future.wait([
                BlocProvider.of<CurrentChatCubit>(context)
                    .getCurrentChatViaApi(),
                BlocProvider.of<CurrentChatCubit>(context)
                    .getFutureConnectedPrivateEventsFromApi(
                  limitOffsetFilter: LimitOffsetFilter(
                    limit: 10,
                    offset: 0,
                  ),
                ),
                BlocProvider.of<CurrentChatCubit>(context)
                    .getGroupchatUsersViaApi(),
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
              ChatInfoPageLeaveChat(),
            ]),
          )
        ],
      ),
    );
  }
}
