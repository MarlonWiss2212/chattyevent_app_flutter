import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:social_media_app_flutter/core/utils/ad_helper.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/ads/custom_banner_ad.dart';

class ChatList extends StatefulWidget {
  final List<GroupchatEntity> chats;
  const ChatList({super.key, required this.chats});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final int _kAdIndex = 4;

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
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
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
          final message = widget.chats[index].messages != null &&
                  widget.chats[index].messages!.isNotEmpty
              ? widget.chats[index].messages!.first
              : null;
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: widget.chats[index].profileImageLink != null
                  ? NetworkImage(widget.chats[index].profileImageLink!)
                  : null,
              backgroundColor: widget.chats[index].profileImageLink == null
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : null,
            ),
            title: Hero(
              tag: "${widget.chats[index].id} title",
              child: Text(
                widget.chats[index].title ?? "Kein Titel",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            subtitle: message != null
                ? Text(
                    //${message.createdBy}:
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
                  chatToSet: widget.chats[index],
                  loadChatFromApiToo: true,
                  groupchatId: widget.chats[index].id,
                ),
              );
            },
          );
        },
        childCount: widget.chats.length + (_ad != null ? 1 : 0),
      ),
    );
  }
}
