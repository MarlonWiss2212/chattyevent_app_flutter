import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/new_private_event/select_groupchat_list_item_new_private_event.dart';

class SelectGroupchatHorizontalListNewPrivateEvent extends StatelessWidget {
  final Function(GroupchatEntity groupchat) newGroupchatSelected;
  const SelectGroupchatHorizontalListNewPrivateEvent({
    super.key,
    required this.newGroupchatSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatStateLoaded) {
          // only if you know that the token exists
          final authstate =
              BlocProvider.of<AuthBloc>(context).state as AuthStateLoaded;
          Map<String, dynamic> tokenPayload = Jwt.parseJwt(authstate.token);

          List<GroupchatEntity> filteredChats = [];

          for (final chat in state.chats) {
            bool currentUserIsAdmin = false;
            for (final chatUser in chat.users) {
              if (chatUser.userId == tokenPayload["sub"]) {
                chatUser.admin != null && chatUser.admin!
                    ? currentUserIsAdmin = true
                    : null;
                break;
              }
            }
            if (currentUserIsAdmin) {
              filteredChats.add(chat);
            }
          }

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SelectGroupchatListItemNewPrivateEvent(
                onTap: () {
                  newGroupchatSelected(filteredChats[index]);
                },
                groupchat: filteredChats[index],
              );
            },
            itemCount: filteredChats.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
          );
        } else if (state is ChatStateLoading) {
          return Center(child: PlatformCircularProgressIndicator());
        } else {
          return Center(
            child: PlatformTextButton(
              child: Text(
                state is ChatStateError ? state.message : "Chats Laden",
              ),
              onPressed: () => BlocProvider.of<ChatBloc>(context).add(
                ChatRequestEvent(),
              ),
            ),
          );
        }
      },
    );
  }
}
