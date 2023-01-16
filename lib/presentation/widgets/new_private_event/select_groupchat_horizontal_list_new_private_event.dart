import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/image_with_label_button.dart';

class SelectGroupchatHorizontalListNewPrivateEvent extends StatelessWidget {
  final Function(GroupchatEntity groupchat) newGroupchatSelected;
  const SelectGroupchatHorizontalListNewPrivateEvent({
    super.key,
    required this.newGroupchatSelected,
  });

  @override
  Widget build(BuildContext context) {
    String currentUserId = "";

    final authState = BlocProvider.of<AuthCubit>(context).state;

    if (authState is AuthStateLoaded) {
      currentUserId = Jwt.parseJwt(authState.token)["sub"];
    }

    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatStateLoaded) {
          List<GroupchatEntity> filteredChats = [];

          for (final chat in state.chats) {
            bool currentUserIsAdmin = false;
            for (final chatUser in chat.users) {
              if (chatUser.userId == currentUserId) {
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

          return SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 100,
                  height: 100,
                  child: ImageWithLabelButton(
                    label: filteredChats[index].title ?? "Kein Titel",
                    imageLink: filteredChats[index].profileImageLink,
                    onTap: () => newGroupchatSelected(filteredChats[index]),
                  ),
                );
              },
              itemCount: filteredChats.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
            ),
          );
        } else if (state is ChatStateLoading) {
          return SizedBox(
            height: 100,
            child: Center(
              child: PlatformCircularProgressIndicator(),
            ),
          );
        } else {
          return SizedBox(
            height: 100,
            child: Center(
              child: PlatformTextButton(
                child: Text(
                  state is ChatStateError ? state.message : "Chats Laden",
                ),
                onPressed: () => BlocProvider.of<ChatCubit>(context).getChats(),
              ),
            ),
          );
        }
      },
    );
  }
}
