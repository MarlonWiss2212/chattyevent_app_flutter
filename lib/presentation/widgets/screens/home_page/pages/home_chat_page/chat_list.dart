import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatList extends StatefulWidget {
  final List<ChatEntity> chats;
  const ChatList({super.key, required this.chats});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  Widget messageLitTile(int index) {
    final MessageEntity? message = widget.chats[index].groupchat != null
        ? widget.chats[index].groupchat!.latestMessage
        : widget.chats[index].privateEvent != null
            ? widget.chats[index].privateEvent!.latestMessage
            : widget.chats[index].user != null
                ? widget.chats[index].user!.latestMessage
                : null;

    final NetworkImage? backgroundImage =
        widget.chats[index].groupchat?.profileImageLink != null
            ? NetworkImage(
                widget.chats[index].groupchat!.profileImageLink!,
              )
            : widget.chats[index].privateEvent?.coverImageLink != null
                ? NetworkImage(
                    widget.chats[index].privateEvent!.coverImageLink!,
                  )
                : widget.chats[index].user?.profileImageLink != null
                    ? NetworkImage(
                        widget.chats[index].user!.profileImageLink!,
                      )
                    : null;

    final String? title = widget.chats[index].groupchat?.title != null
        ? widget.chats[index].groupchat!.title!
        : widget.chats[index].privateEvent?.title != null
            ? widget.chats[index].privateEvent!.title!
            : widget.chats[index].user?.username != null
                ? widget.chats[index].user!.username!
                : null;

    final String? id = widget.chats[index].groupchat?.id != null
        ? widget.chats[index].groupchat!.id
        : widget.chats[index].privateEvent?.id != null
            ? widget.chats[index].privateEvent!.id
            : widget.chats[index].user?.id != null
                ? widget.chats[index].user!.id
                : null;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: backgroundImage,
        backgroundColor: backgroundImage == null
            ? Theme.of(context).colorScheme.surface
            : null,
      ),
      title: Hero(
        tag: "$id title",
        child: Text(
          title ?? "",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      trailing: message?.readBy == null ||
              message!.readBy!.contains(
                BlocProvider.of<AuthCubit>(context).state.currentUser.id,
              )
          ? null
          : Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
      subtitle: message != null
          ? Text(
              "${message.message}",
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          : const Text(
              "Keine Nachricht",
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
      onTap: () {
        if (widget.chats[index].groupchat != null) {
          AutoRouter.of(context).push(
            GroupchatRouteWrapper(
              groupchat: widget.chats[index].groupchat!,
              groupchatId: widget.chats[index].groupchat!.id,
            ),
          );
        } else if (widget.chats[index].privateEvent != null) {
          AutoRouter.of(context).push(
            PrivateEventWrapperRoute(
              privateEventId: widget.chats[index].privateEvent!.id,
              privateEventStateToSet: CurrentPrivateEventState.fromPrivateEvent(
                privateEvent: widget.chats[index].privateEvent!,
              ),
              children: [
                PrivateEventTabRoute(
                  privateEventId: widget.chats[index].privateEvent!.id,
                  children: [
                    PrivateEventTabChat(
                      privateEventId: widget.chats[index].privateEvent!.id,
                    ),
                  ],
                )
              ],
            ),
          );
        } else if (widget.chats[index].user != null) {
          AutoRouter.of(context).push(
            ProfileWrapperRoute(
              user: widget.chats[index].user!,
              userId: widget.chats[index].user!.id,
              children: [
                ProfileChatRoute(
                  userId: widget.chats[index].user!.id,
                ),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // doesnt need load more because all loaded on initial
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return messageLitTile(index);
        },
        childCount: widget.chats.length,
      ),
    );
  }
}
