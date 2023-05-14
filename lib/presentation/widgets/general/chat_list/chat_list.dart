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
  BannerAd? _ad;

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
    BannerAd(
      adUnitId: AdHelper.chatListBannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (_ad != null && index == _kAdIndex) {
            return Container(
              width: _ad!.size.width.toDouble(),
              height: 72.0,
              alignment: Alignment.center,
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
