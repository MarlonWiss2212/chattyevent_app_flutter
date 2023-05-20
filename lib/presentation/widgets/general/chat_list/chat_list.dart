import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/ad_helper.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class ChatList extends StatefulWidget {
  final List<CurrentChatState> chatStates;
  const ChatList({super.key, required this.chatStates});

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
    if (widget.chatStates.length < _kAdIndex) {
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
          final message = widget.chatStates[index].messages.isNotEmpty
              ? widget.chatStates[index].messages.first
              : null;

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: widget
                          .chatStates[index].currentChat.profileImageLink !=
                      null
                  ? NetworkImage(
                      widget.chatStates[index].currentChat.profileImageLink!)
                  : null,
              backgroundColor:
                  widget.chatStates[index].currentChat.profileImageLink == null
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : null,
            ),
            title: Hero(
              tag: "${widget.chatStates[index]..currentChat.id} title",
              child: Text(
                widget.chatStates[index].currentChat.title ?? "",
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
              AutoRouter.of(context).push(
                ChatPageWrapperRoute(
                  chatStateToSet: widget.chatStates[index],
                  groupchatId: widget.chatStates[index].currentChat.id,
                ),
              );
            },
          );
        },
        childCount: widget.chatStates.length + (_ad != null ? 1 : 0),
      ),
    );
  }
}
