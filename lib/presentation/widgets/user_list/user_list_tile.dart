import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class UserListTile extends StatefulWidget {
  final String? customTitle;
  final UserEntity user;
  final Widget? subtitle;
  final Widget? trailing;
  final List<PopupMenuEntry<void>>? items;

  const UserListTile({
    super.key,
    this.customTitle,
    this.subtitle,
    required this.user,
    this.trailing,
    this.items,
  });

  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  late Offset tapXY;
  late RenderBox overlay;

  RelativeRect get relRectSize =>
      RelativeRect.fromSize(tapXY & const Size(40, 40), overlay.size);

  void getPosition(TapDownDetails detail) {
    tapXY = detail.globalPosition;
  }

  @override
  Widget build(BuildContext context) {
    overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    return GestureDetector(
      onTapDown: getPosition,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: widget.user.profileImageLink != null
              ? NetworkImage(widget.user.profileImageLink!)
              : null,
          backgroundColor: widget.user.profileImageLink == null
              ? Theme.of(context).colorScheme.secondaryContainer
              : null,
        ),
        title: Hero(
          tag: "${widget.user.id} username",
          child: Text(
            widget.customTitle ?? widget.user.username ?? "Kein Username",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        subtitle: widget.subtitle,
        onTap: () {
          AutoRouter.of(context).root.push(
                ProfilePageRoute(
                    userId: widget.user.id,
                    loadUserFromApiToo: true,
                    userToSet: widget.user),
              );
        },
        onLongPress: () {
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              tapXY.dx,
              tapXY.dy,
              overlay.size.width - tapXY.dx,
              overlay.size.height - tapXY.dy,
            ),
            items: widget.items ?? [],
          );
        },
        trailing: widget.trailing,
      ),
    );
  }
}
