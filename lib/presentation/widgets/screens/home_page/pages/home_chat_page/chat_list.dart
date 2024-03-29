import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
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
  Widget messageLitTile(int index, String userId) {
    final MessageEntity? message = widget.chats[index].groupchat != null
        ? widget.chats[index].groupchat!.latestMessage
        : widget.chats[index].event != null
            ? widget.chats[index].event!.latestMessage
            : widget.chats[index].user != null
                ? widget.chats[index].user!.latestMessage
                : null;

    final CachedNetworkImageProvider? backgroundImage =
        widget.chats[index].groupchat?.profileImageLink != null
            ? CachedNetworkImageProvider(
                widget.chats[index].groupchat!.profileImageLink!,
                cacheKey: widget.chats[index].groupchat!.profileImageLink!
                    .split("?")[0],
              )
            : widget.chats[index].event?.coverImageLink != null
                ? CachedNetworkImageProvider(
                    widget.chats[index].event!.coverImageLink!,
                    cacheKey: widget.chats[index].event!.coverImageLink!
                        .split("?")[0],
                  )
                : widget.chats[index].user?.profileImageLink != null
                    ? CachedNetworkImageProvider(
                        widget.chats[index].user!.profileImageLink!,
                        cacheKey: widget.chats[index].user!.profileImageLink!
                            .split("?")[0],
                      )
                    : null;

    final String? title = widget.chats[index].groupchat?.title != null
        ? widget.chats[index].groupchat!.title!
        : widget.chats[index].event?.title != null
            ? widget.chats[index].event!.title!
            : widget.chats[index].user?.username != null
                ? widget.chats[index].user!.username!
                : null;

    final String? id = widget.chats[index].groupchat?.id != null
        ? widget.chats[index].groupchat!.id
        : widget.chats[index].event?.id != null
            ? widget.chats[index].event!.id
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
      trailing: message?.readBy == null || message!.readBy.contains(userId)
          ? null
          : Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
      subtitle: message != null && message.message != null
          ? Text(
              "${message.message}",
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          : null,
      onTap: () {
        if (widget.chats[index].groupchat != null) {
          AutoRouter.of(context).push(
            GroupchatRouteWrapper(
              groupchat: widget.chats[index].groupchat!,
              groupchatId: widget.chats[index].groupchat!.id,
            ),
          );
        } else if (widget.chats[index].event != null) {
          AutoRouter.of(context).push(
            EventWrapperRoute(
              eventId: widget.chats[index].event!.id,
              eventStateToSet: CurrentEventState.fromEvent(
                event: widget.chats[index].event!,
              ),
              children: [
                EventTabRoute(
                  eventId: widget.chats[index].event!.id,
                  children: [
                    EventTabChat(
                      eventId: widget.chats[index].event!.id,
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
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) => p.currentUser.id != c.currentUser.id,
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return messageLitTile(index, state.currentUser.id);
            },
            childCount: widget.chats.length,
          ),
        );
      },
    );
  }
}
