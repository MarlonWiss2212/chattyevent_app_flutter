import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_circle_image.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_description.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_leave_chat.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_private_event_list/chat_info_page_private_event_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/left_user_list/chat_info_page_left_user_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/user_list/chat_info_page_user_list.dart';

class ChatInfoPage extends StatelessWidget {
  const ChatInfoPage({@PathParam('id') required this.groupchatId, super.key});
  final String groupchatId;

  @override
  Widget build(BuildContext context) {
    // should get the private events for this chat in future for more effeciancy
    BlocProvider.of<PrivateEventCubit>(context).getPrivateEventsViaApi();

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: BlocBuilder<CurrentChatCubit, CurrentChatState>(
          buildWhen: (previous, current) =>
              previous.currentChat.title != current.currentChat.title,
          builder: (context, state) {
            return Hero(
              tag: "$groupchatId title",
              child: Text(
                state.currentChat.title != null
                    ? state.currentChat.title!
                    : "Kein Titel",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<CurrentChatCubit, CurrentChatState>(
            builder: (context, state) {
              if (state.loadingChat) {
                return const LinearProgressIndicator();
              }
              return const SizedBox();
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  SizedBox(height: 20),
                  ChatInfoPageCircleImage(),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
