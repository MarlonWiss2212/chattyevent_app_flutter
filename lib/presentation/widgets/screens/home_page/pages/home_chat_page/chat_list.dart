import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:chattyevent_app_flutter/core/utils/ad_helper.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class ChatList extends StatefulWidget {
  final List<ChatEntity> chats;
  const ChatList({super.key, required this.chats});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final int _kAdIndex = 1;
  NativeAd? _ad;

  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _ad != null) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  @override
  void initState() {
    super.initState();
    if (widget.chats.length < _kAdIndex) {
      return;
    }
    Future.delayed(Duration.zero, () {
      NativeAd(
        adUnitId: AdHelper.chatListNativeAdUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _ad = ad as NativeAd;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(
          templateType: TemplateType.small,
          mainBackgroundColor: Theme.of(context).colorScheme.background,
          cornerRadius: 8,
          callToActionTextStyle: NativeTemplateTextStyle(
            textColor: Theme.of(context).colorScheme.onBackground,
            backgroundColor: Theme.of(context).colorScheme.background,
            style: NativeTemplateFontStyle.monospace,
            size: 16.0,
          ),
          primaryTextStyle: NativeTemplateTextStyle(
            textColor: Theme.of(context).colorScheme.onBackground,
            backgroundColor: Theme.of(context).colorScheme.background,
            style: NativeTemplateFontStyle.italic,
            size: 16.0,
          ),
          secondaryTextStyle: NativeTemplateTextStyle(
            textColor: Theme.of(context).colorScheme.onBackground,
            backgroundColor: Theme.of(context).colorScheme.background,
            style: NativeTemplateFontStyle.bold,
            size: 16.0,
          ),
          tertiaryTextStyle: NativeTemplateTextStyle(
            textColor: Theme.of(context).colorScheme.onBackground,
            backgroundColor: Theme.of(context).colorScheme.background,
            style: NativeTemplateFontStyle.normal,
            size: 16.0,
          ),
        ),
      ).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    // doesnt need load more because all loaded on initial
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (_ad != null && index == _kAdIndex) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: 80,
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: 90,
              ),
              child: AdWidget(ad: _ad!),
            );
          }

          index = _getDestinationItemIndex(index);
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
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : null,
            ),
            title: Hero(
              tag: "$id title",
              child: Text(
                title ?? "",
                style: Theme.of(context).textTheme.titleMedium,
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
                  ChatPageWrapperRoute(
                    groupchat: widget.chats[index].groupchat!,
                    groupchatId: widget.chats[index].groupchat!.id,
                  ),
                );
              } else if (widget.chats[index].privateEvent != null) {
                AutoRouter.of(context).push(
                  PrivateEventWrapperPageRoute(
                    privateEventId: widget.chats[index].privateEvent!.id,
                    privateEventStateToSet:
                        CurrentPrivateEventState.fromPrivateEvent(
                      privateEvent: widget.chats[index].privateEvent!,
                    ),
                    children: [
                      PrivateEventTabPageRoute(
                        children: [PrivateEventTabChatRoute()],
                      )
                    ],
                  ),
                );
              } else if (widget.chats[index].user != null) {
                AutoRouter.of(context).push(
                  ProfileWrapperPageRoute(
                    userToSet: widget.chats[index].user!,
                    userId: widget.chats[index].user!.id,
                    children: [ProfileChatPageRoute()],
                  ),
                );
                // push user page
              }
            },
          );
        },
        childCount: widget.chats.length + (_ad != null ? 1 : 0),
      ),
    );
  }
}
