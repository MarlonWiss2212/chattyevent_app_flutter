import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_permission_enum.dart';
import 'package:flutter/material.dart';

class PrivateEventPermissionsMenu extends StatefulWidget {
  final String text;
  final void Function(PrivateEventPermissionEnum value) changePermission;
  final PrivateEventPermissionEnum? value;
  const PrivateEventPermissionsMenu({
    super.key,
    required this.text,
    required this.changePermission,
    required this.value,
  });

  @override
  State<PrivateEventPermissionsMenu> createState() =>
      _PrivateEventPermissionsMenuState();
}

class _PrivateEventPermissionsMenuState
    extends State<PrivateEventPermissionsMenu> {
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
          child: const Text("Nur Ersteller"),
          onTap: () => widget.changePermission(
            PrivateEventPermissionEnum.createronly,
          ),
        ),
        PopupMenuItem(
          child: const Text("Nur Organisatoren"),
          onTap: () => widget.changePermission(
            PrivateEventPermissionEnum.organizersonly,
          ),
        ),
        PopupMenuItem(
          child: const Text("Alle"),
          onTap: () => widget.changePermission(
            PrivateEventPermissionEnum.everyone,
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
                  : widget.value == PrivateEventPermissionEnum.createronly
                      ? "Nur Ersteller"
                      : widget.value ==
                              PrivateEventPermissionEnum.organizersonly
                          ? "Nur Organisatoren"
                          : widget.value == PrivateEventPermissionEnum.everyone
                              ? "Alle"
                              : "Keine Info",
            )
          ],
        ),
      ),
    );
  }
}
