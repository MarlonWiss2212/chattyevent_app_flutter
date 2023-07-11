import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_permission_enum.dart';
import 'package:flutter/material.dart';

class GroupchatPermissionsMenu extends StatefulWidget {
  final String text;
  final void Function(GroupchatPermissionEnum value) changePermission;
  final GroupchatPermissionEnum? value;
  const GroupchatPermissionsMenu({
    super.key,
    required this.text,
    required this.changePermission,
    required this.value,
  });

  @override
  State<GroupchatPermissionsMenu> createState() =>
      _GroupchatPermissionsMenuState();
}

class _GroupchatPermissionsMenuState extends State<GroupchatPermissionsMenu> {
  late Offset tapXY;
  late RenderBox overlay;

  RelativeRect get relRectSize =>
      RelativeRect.fromSize(tapXY & const Size(40, 40), overlay.size);

  void getPosition(TapDownDetails detail) {
    tapXY = detail.globalPosition;
  }

  _showMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        tapXY.dx,
        tapXY.dy,
        overlay.size.width - tapXY.dx,
        overlay.size.height - tapXY.dy,
      ),
      items: [
        PopupMenuItem(
          child: const Text("Nur Admins"),
          onTap: () => widget.changePermission(
            GroupchatPermissionEnum.adminsonly,
          ),
        ),
        PopupMenuItem(
          child: const Text("Alle"),
          onTap: () => widget.changePermission(
            GroupchatPermissionEnum.everyone,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    return GestureDetector(
      onTapDown: getPosition,
      onTap: () => _showMenu(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.value == null
                  ? "Standarddaten"
                  : widget.value == GroupchatPermissionEnum.adminsonly
                      ? "Nur Admins"
                      : widget.value == GroupchatPermissionEnum.everyone
                          ? "Alle"
                          : "Keine Info",
            )
          ],
        ),
      ),
    );
  }
}
