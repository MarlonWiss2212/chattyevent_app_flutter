import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/custom_divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/input_fields/edit_input_text_field.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_description.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_leave_chat.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_private_event_list/chat_info_page_private_event_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_left_user_list/chat_info_page_left_user_list.dart';
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
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: BlocBuilder<CurrentChatCubit, CurrentChatState>(
                buildWhen: (previous, current) =>
                    previous.currentChat.profileImageLink !=
                    current.currentChat.profileImageLink,
                builder: (context, state) {
                  if (state.currentChat.profileImageLink == null) {
                    return const SizedBox();
                  }
                  return Image.network(
                    state.currentChat.profileImageLink!,
                    fit: BoxFit.cover,
                  );
                },
              ),
              title: BlocBuilder<CurrentChatCubit, CurrentChatState>(
                buildWhen: (previous, current) =>
                    previous.currentChat.title != current.currentChat.title,
                builder: (context, state) {
                  return Hero(
                    tag: "$groupchatId title",
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: EditInputTextField(
                        text: state.currentChat.title ?? "",
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.apply(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                        onSaved: (text) => print(text),
                      ),
                    ),
                  );
                },
              ),
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
